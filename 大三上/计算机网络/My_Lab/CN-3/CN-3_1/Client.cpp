#include <iostream>
#include<fstream>
#include<WinSock2.h>
#include<time.h>
#include<stdio.h>
#include<string>
#include<cstring>
#include<iomanip>
#include<math.h>
using namespace std;

#pragma comment(lib,"ws2_32.lib")
#pragma warning(disable:4996)

typedef unsigned char BYTE; // 1字节
typedef unsigned short WORD; // 2字节
typedef unsigned long DWORD; // 4字节

#define Max_Size 8192
#define MAX_TIME 100

// 定义消息结构体，报文
typedef struct Message
{
	WORD source_port = 0, dest_port = 0;	//2字节源端口和2字节目标端口
	DWORD seq_num = 0, ack_num = 0;			//4字节序列号和4字节确认号
	WORD  length = 0;					//2字节长度
	BYTE  flag = 0;				     //1字节标志位
	WORD checksum = 0;					//2字节校验和
	char msg[Max_Size] = { 0 };// 消息内容
}msg;

// 定义UDP伪首部结构体
typedef struct UDP_PseudoHead
{
	DWORD source_ip = 0, dest_ip = 0;		//源IP和目标IP
	char zero = 0;// 预留字段，填充0
	char protocol = 0;// 协议字段
	WORD length = sizeof(msg);// 长度字段
}psh;

void setlength(msg* msg, short int len) 
{
	msg->length = len & 0x0004;
}

short int getlength(msg& msg)
{
	return msg.length;
}

//ACK=0x01, SYN=0x02, FIN=0x04, END=0x08
// 清除标志位
void cleanflag(msg* msg) 
{
	msg->flag |= 0x0;
}
// 判断是否是ACK
bool isACK(msg* msg)
{
	return msg->flag & 0x01;
}
// 判断是否是SYN
bool isSYN(msg* msg)
{
	return msg->flag & 0x02;
}
// 判断是否是FIN
bool isFIN(msg* msg)
{
	return msg->flag & 0x04;
}
// 判断是否是END
bool isEND(msg* msg)
{
	return msg->flag & 0x08;
}

// 设置ACK标志位
void setACK(msg* msg) 
{
	msg->flag |= 0x01;
}
// 设置SYN标志位
void setSYN(msg* msg)
{
	msg->flag |= 0x02;
}
// 设置FIN标志位
void setFIN(msg* msg)
{
	msg->flag |= 0x04;
}
// 设置END标志位
void setEND(msg* msg) 
{
	msg->flag |= 0x08;
}
// 设置消息内容
void setMsg(msg* msg, char* data)
{
	memcpy(msg->msg, data, Max_Size);
};

//rdt2.0考虑差错比特的情况，增加了差错检测、接收端反馈（NAK/ACK，否定/肯定确认）、发送端重传
// 但无法处理ACK/NAK受损的情况。如果受损发送端只是重传当前数据分组，会导致冗余分组
// 接收方也不知道它上次发送的ACK/NAK是否被正确接收
// rdt2.1中发送端在每个分组中增加序列号，并且接收端丢弃重复的分组
// rdt2.2丢弃NAK，只使用ACK
// rdt3.0考虑丢包和差错比特

// 发送消息时设置校验和
void SetCheckSum(msg* message, psh* ph) 
{
	//消息的校验和先设为0
	message->checksum = 0;
	int sum = 0;
	int len_pseudo = sizeof(psh);
	int len_msg = sizeof(msg);

	// 计算伪首部的校验和，将伪首部的每两个字节作为16位的整数相加
	for (int i = 0; i < len_pseudo / 2; i++) 
	{
		sum += ((WORD*)ph)[i];
	}
	// 计算消息的校验和，将消息的每两个字节作为16位的整数相加
	for (int i = 0; i < len_msg / 2; i++) 
	{
		sum += ((WORD*)message)[i];
	}
	// 处理进位，如果有进位，就将进位部分加回到sum的低16位中。
	while (sum >> 16) 
	{
		sum = (sum & 0xFFFF) + (sum >> 16);
	}
	// 将校验和取反并赋值给消息的校验和字段
	message->checksum = ~sum;
};

// 接收消息时验证校验和
bool vertifyCheckSum(msg* message, psh* ph)
{
	int sum = 0;
	int len_pseudo = sizeof(psh);
	int len_msg = sizeof(msg);

	// 计算伪首部的校验和
	for (int i = 0; i < len_pseudo / 2; i++) 
	{
		sum += ((WORD*)ph)[i];
	}

	// 计算消息的校验和，如果有进位，就将进位部分加回到sum的低16位中。
	for (int i = 0; i < len_msg / 2; i++) 
	{
		sum += ((WORD*)message)[i];
	}

	// 处理进位
	while (sum >> 16) 
	{
		sum = (sum & 0xFFFF) + (sum >> 16);
	}

	// 验证校验和是否为0xFFFF
	return sum == 0xFFFF;
};

SOCKET sockClient; // 定义客户端套接字
SOCKADDR_IN addr_client; // 定义客户端地址结构体
SOCKADDR_IN addr_server; // 定义服务器地址结构体

char  ip_client[] = "127.0.0.1"; // 定义客户端IP
WORD  port_client = 7777; // 定义客户端端口
char ip_server[] = "127.0.0.1"; // 定义服务器IP
WORD  port_server = 8888; // 定义服务器端口

char ip_route[] = "127.0.0.1"; // 定义路由器IP
WORD  port_route = 9999; // 定义路由器端口

psh ph;		//伪首部

void ClientInit()
{
	WSADATA wsadata;
	int res;
	res = WSAStartup(MAKEWORD(2, 2), &wsadata);
	if (res != 0) 
	{
		cout << "Startup failed. Err: " << GetLastError() << endl;
		return;
	}
	else
	{
		cout << "Startup success!" << endl;
	}

	// 设置客户端地址结构
	addr_client.sin_port = htons(port_client);					//port
	addr_client.sin_addr.S_un.S_addr = inet_addr(ip_client); //ip addr
	addr_client.sin_family = AF_INET;
	// 设置服务器地址结构
	addr_server.sin_port = htons(port_route);
	addr_server.sin_addr.S_un.S_addr = inet_addr(ip_route);
	addr_server.sin_family = AF_INET;
	// 创建套接字
	sockClient = socket(AF_INET, SOCK_DGRAM, 0);
	if (sockClient == INVALID_SOCKET) 
	{
		cout << "Socket create failed. Err: " << GetLastError() << endl;
		return;
	}
	else
	{
		cout << "Socket create success!" << endl;
	}

	// 设置套接字为非阻塞模式
	u_long imode = 1;
	ioctlsocket(sockClient, FIONBIO, &imode);//非阻塞

	// 将套接字绑定到客户端地址
	res = bind(sockClient, (SOCKADDR*)&addr_client, sizeof(SOCKADDR_IN));
	if (res == SOCKET_ERROR)
	{
		cout << "Bind failed. Err: " << GetLastError() << endl;
		return;
	}
	else
	{
		cout << "Bind success!" << endl;
	}

	//初始化伪头部
	memset(&ph, 0, sizeof(psh));
	ph.source_ip = inet_addr(ip_client);
	ph.dest_ip = inet_addr(ip_server);

	//初始化完成，客户端连接
	cout << "Initialization successful. Client is now connecting..." << endl;
};

bool establishConnect() 
{
	int len = sizeof(SOCKADDR_IN);
	char recBuffer[sizeof(msg)];	//接收缓冲区
	char sendBuffer[sizeof(msg)];	//发送缓冲区

	//初始化recBuffer和sendBuffer两个缓冲区，用于存储接收和发送的消息
	memset(recBuffer, 0, sizeof(msg));
	memset(sendBuffer, 0, sizeof(msg));

	//创建指向发送和接收消息的指针sed和rec
	msg* sed = (msg*)sendBuffer;
	msg* rec = (msg*)recBuffer;

	// 第一次握手：Client发送SYN，标记位为SYN=1,seq=0,ack=0
	setSYN(sed);		//设置SYN
	sed->seq_num = 0;	//设置seq=0
	sed->ack_num = 0;	//设置ack=0
	sed->source_port = port_client;//源端口
	sed->dest_port = port_server;//目的端口
	SetCheckSum(sed, &ph);	//设置校验和

	//将SYN数据包发送到服务器
	sendto(sockClient, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
	cout << "Client: Sent SYN (First Handshake)" << endl;

	//启动定时器（start）以处理潜在的超时情况
	clock_t start = clock(); 

	// 第二次握手：Client接收SYN, ACK
	while (recvfrom(sockClient, recBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, &len) <= 0) 
	{
		//如果在指定的时间内（MAX_TIME）未收到响应，则重新传输SYN数据包
		if (clock() - start >= MAX_TIME) 
		{
			//超时重传
			sendto(sockClient, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
			start = clock();
		}
	}
	//cout << "Client: Received SYN, ACK (Second Handshake)" << endl;

	//检查接收到的数据包是否是有效的SYN-ACK数据包
	if (isACK(rec) && isSYN(rec) && vertifyCheckSum(rec, &ph)) 
	{
		//接收成功
		cout << "Client: Received packet (SYN, ACK) validation successful!(Second Shake)" << endl;
		//第三次握手，ACK=1，seq=1，ack=1
		//如果数据包有效，则准备一个ACK数据包并发送以确认服务器
		memset(sendBuffer, 0, sizeof(msg));
		setACK(sed);	//设置ack
		sed->seq_num = 1;
		sed->ack_num = 1;
		sed->source_port = port_client;
		sed->dest_port = port_server;

		SetCheckSum(sed, &ph);
		// 第三次握手：Client发送ACK
		sendto(sockClient, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
		cout << "Client: Sent ACK (Third Handshake)" << endl;
	}
	else 
	{
		cout << "Client: Received packet (SYN, ACK) validation failed!" << endl;
		return false;
	}
	cout << "Client: Connection established successfully!" << endl;
	return true;
};

// 源自于应用程序的报文分组打包成报文段
msg make_pkt(int seq, char* data, unsigned short len) 
{
	msg message;// 创建一个消息结构体
	memset(&message, 0, sizeof(msg));// 初始化消息结构体，将其内容全部设置为0
	message.source_port = port_client;// 设置消息的源端口
	message.dest_port = port_server;// 设置消息的目标端口
	message.length = len;// 设置消息的长度
	message.seq_num = seq;// 设置消息的序列号
	memcpy(message.msg, data, len);// 复制数据到消息的数据字段

	psh ph;		// 创建一个伪首部结构体
	memset(&ph, 0, sizeof(psh));// 初始化伪首部结构体，将其内容全部设置为0
	ph.source_ip = inet_addr(ip_client);// 设置伪首部的源IP地址
	ph.dest_ip = inet_addr(ip_server);// 设置伪首部的目标IP地址
	SetCheckSum(&message, &ph);	//设置校验和

	return message;// 返回构造好的消息结构体
}
// 路由：服务器端发来的包，则不进行处理，直接转发给客户端
// 发送数据的状态机函数
void rdt3_send_FSM(unsigned long length_file, char* file, char* filename) 
{
	// 计算总共需要发送的数据包数量
	int packetNUM = int(length_file / Max_Size) + (length_file % Max_Size ? 1 : 0);
	cout << "packetNUM: " << packetNUM << endl;
	cout << endl;

	int count = 0;// 当前数据包索引
	int state = 0;// 当前状态
	int len = sizeof(SOCKADDR_IN);// 地址结构体长度
	int	packetDataLen = min(Max_Size, length_file - count * Max_Size);// 当前数据包中的数据长度
	char* dataBuffer = new char[Max_Size];// 数据缓冲区
	char* pktBuffer = new char[sizeof(msg)];// 数据包缓冲区
	char* recpktBuffer = new char[sizeof(msg)];// 接收数据包缓冲区
	msg sndpkt;// 发送的数据包
	clock_t start_timer;// 计时器

	msg* rec = (msg*)recpktBuffer;// 接收到的数据包

	cout << "本文件数据长度为 " << length_file << "Bytes, 需要传输" << packetNUM << "个数据包" << endl;

	while (1) 
	{
		//发送传输结束报文
		if (count == packetNUM)
		{
			// 设置为非阻塞模式
			u_long imode = 1;
			ioctlsocket(sockClient, FIONBIO, &imode);

			char* sendBuffer = new char[sizeof(msg)];
			memset(sendBuffer, 0, sizeof(msg));
			msg* sed = (msg*)sendBuffer;

			// 设置传输结束标志
			setEND(sed);
			sed->source_port = port_client;// 设置源端口
			sed->dest_port = port_server;// 设置目标端口
			string fn = filename;
			int filename_len = sizeof(fn);

			memcpy(sed->msg, filename, filename_len);// 复制文件名到消息数据字段
			sed->length = filename_len;// 设置消息长度
			SetCheckSum(sed, &ph);	//设置校验和

			// 发送传输结束报文
			sendto(sockClient, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
			cout << "Client: Sent packet (END)" << endl;

			clock_t start_timer = clock(); //开始计时
			// 等待接收服务器的确认
			while (recvfrom(sockClient, recpktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, &len) <= 0 || !(isEND(rec) && isACK(rec))) 
			{
				// 超时重传
				if (clock() - start_timer >= MAX_TIME)
				{
					// 超时重传传输结束报文
					sendto(sockClient, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
					cout << "Client: Sent packet (END), Retransmitting..." << endl;
					start_timer = clock();
				}
			}
			// 接收到服务器的确认，文件传输完成
			if (isEND(rec) && isACK(rec) && vertifyCheckSum(rec, &ph))
			{
				cout << "Client: Received server packet (END, ACK), File transfer completed." << endl;
				return;
			}
			else
				continue;
		}
		// 计算当前数据包的数据长度
		packetDataLen = min(Max_Size, length_file - count * Max_Size);

		switch (state)
		{
		/*
		在这个状态下，数据被复制到缓冲区，构造数据包，设置序列号为2，并发送数据包
		状态0表示发送方准备发送一个序列号为2的数据包
		*/
		case 0:
			// 复制数据到缓冲区，构造数据包，设置序列号为2
			memcpy(dataBuffer, file + count * Max_Size, packetDataLen);

			//rdt3.0：源自于应用程序的报文分组打包成报文段，设置序列号为2
			sndpkt = make_pkt(2, dataBuffer, packetDataLen);
			//rdt3.0：存储至缓冲区
			memcpy(pktBuffer, &sndpkt, sizeof(msg));

			// rdt3.0: 发送数据包，将打包完成的报文段推送至信道
			sendto(sockClient, pktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
			//rdt3.0: 发送完成后，设置定时器事件
			start_timer = clock();// 开始计时
			state = 1;// rdt3.0: 进入下一状态，为等待序号为2报文段的ack应答状态
			cout << "Case 0: State 0-Sent         " << std::setw(20) << std::left << "seq: 2" << "count : " << std::setw(20) << std::left << count << "length : " << std::setw(20) << std::left << packetDataLen << " checksum : " << std::setw(20) << std::left << sndpkt.checksum << endl;
			break;

		/*
		等待接收来自服务器的确认，如果接收到正确的确认（ACK=2），则进入状态2；否则，根据超时进行重传
		状态1表示发送方已发送数据包，等待来自服务器的确认。
		*/
		case 1:
			//rdt3.0: 超时重传。发送端在规定的超时时间内没有收到服务器的确认消息，发送端会触发超时重传机制。
			//超时重传会重新发送之前发送的数据包，以确保数据的可靠传输。
			if (clock() - start_timer >= MAX_TIME) 
			{
				// 超时重传数据包
				sendto(sockClient, pktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
				cout << "Case 1: State 0-Sent         " << std::setw(20) << std::left << "seq: 2" << "count : " << std::setw(20) << std::left << count << "length : " << std::setw(20) << std::left << packetDataLen << " checksum : " << std::setw(20) << std::left << sndpkt.checksum << std::setw(20) << std::left << " (Retransmitted)" << std::setw(20) << std::left << endl;
				//rdt3.0: 发送完成后，设置定时器事件
				start_timer = clock();
			}

			// 接收服务器的确认
			// rdt3.0: 如果接收到的确认消息（ACK）不正确或者校验和验证失败，发送端会忽略该确认消息，并等待重传。
			// rdt3.0: 超时重传会重新发送之前发送的数据包，以确保数据的正确传输。
			if (recvfrom(sockClient, recpktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, &len)) 
			{
				if (isACK(rec) && vertifyCheckSum(rec, &ph) && rec->ack_num == 2) 
				{
					cout << "Case 1: State 1-Received     " << std::setw(20) << std::left << "ack: 2" << "Ack : " << std::setw(20) << std::left << isACK(rec)<< "  length : " << std::setw(20) << std::left << rec->length  << " checksum : " << std::setw(20) << std::left << rec->checksum << endl;
					state = 2;// rdt3.0: 进入下一状态,即将发送新的序列号为3的数据包
					count++;// 更新数据包索引
					break;
				}
			}
			break;

		/*
		在这个状态下，数据被复制到缓冲区，构造数据包，设置序列号为3，并发送数据包。
		状态2表示发送方准备发送一个序列号为3的数据包。
		*/
		case 2:
			// 复制数据到缓冲区，构造数据包，设置序列号为3
			memcpy(dataBuffer, file + count * Max_Size, packetDataLen);
			//rdt3.0：源自于应用程序的报文分组打包成报文段，设置序列号为3
			sndpkt = make_pkt(3, dataBuffer, packetDataLen);
			//rdt3.0：存储至缓冲区
			memcpy(pktBuffer, &sndpkt, sizeof(msg));

			// rdt3.0: 发送数据包，将打包完成的报文段推送至信道
			sendto(sockClient, pktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
			cout << "Case 2: State 2-Sent         " << std::setw(20) << std::left << "seq: 3" << "count : " << std::setw(20) << std::left << count << "length : " << std::setw(20) << std::left << packetDataLen << " checksum : " << std::setw(20) << std::left << sndpkt.checksum << endl;

			//rdt3.0: 发送完成后，设置定时器事件
			start_timer = clock();// 开始计时
			state = 3;// rdt3.0:  进入下一状态，为等待序号为3报文段的ack应答状态
			break;

		/*
		等待接收来自服务器的确认，如果接收到正确的确认（ACK=3），则进入状态0；否则，根据超时进行重传。
		状态3表示发送方已发送数据包，等待来自服务器的确认。
		*/
		case 3:
			//rdt 3.0: 超时重传.如果发送端在规定的超时时间内没有收到服务器的确认消息，
			//发送端会触发超时重传机制
			if (clock() - start_timer >= MAX_TIME)
			{
				// 超时重传数据包
				sendto(sockClient, pktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
				cout << "Case 3: State 2-Sent         " << std::setw(20) << std::left << "seq: 3" << "count : " << std::setw(20) << std::left << count << "length : " << std::setw(20) << std::left << packetDataLen << " checksum : " << std::setw(20) << std::left << sndpkt.checksum << std::setw(20) << std::left << "(Retransmitted)" << endl;
				//rdt3.0: 发送完成后，设置定时器事件
				start_timer = clock();
			}
			// 接收服务器的确认
			// rdt3.0: 如果接收到的确认消息（ACK）不正确或者校验和验证失败，
			//发送端会忽略该确认消息，并等待超时重传s
			if (recvfrom(sockClient, recpktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, &len)) 
			{
				if (isACK(rec) && vertifyCheckSum(rec, &ph) && rec->ack_num == 3) 
				{
					cout << "Case 3: State 3-Received     " << std::setw(20) << std::left << "ack: 3" << "Ack : " << std::setw(20) << std::left << isACK(rec) << "  length : " << std::setw(20) << std::left << rec->length << " checksum : " << std::setw(20) << std::left << rec->checksum << endl;
					cout << endl;
					state = 0;// 进入下一状态
					count++;// 更新数据包索引
					break;
				}
			}
			break;
		}
	}
}

bool closeConnect() 
{
	int len = sizeof(SOCKADDR_IN);
	char recBuffer[sizeof(msg)];	//接收缓冲区
	char sendBuffer[sizeof(msg)];	//发送缓冲区

	memset(recBuffer, 0, sizeof(msg));
	memset(sendBuffer, 0, sizeof(msg));

	msg* sed = (msg*)sendBuffer;
	msg* rec = (msg*)recBuffer;

	//第一次挥手，客户端发送FIN报文，FIN=1,seq=0,ack=0
	setFIN(sed);		//设置Fin
	sed->seq_num = 0;	//设置seq=0
	sed->ack_num = 0;	//设置ack=0
	sed->source_port = port_client;
	sed->dest_port = port_server;
	SetCheckSum(sed, &ph);	//设置校验和

	//发送
	sendto(sockClient, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
	cout << "Client: Sent packet (FIN) (First wave)" << endl;

	clock_t start = clock(); //开始计时

	//第二次挥手，接收确定服务器端的FIN，ACK报文
	while (recvfrom(sockClient, recBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, &len) <= 0)
	{
		// over time
		if (clock() - start >= MAX_TIME) 
		{
			//超时重传
			sendto(sockClient, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
			cout << "Client: Sent packet (FIN), retransmission(First wave)" << endl;
			start = clock();
		}
	}

	if (isACK(rec) && isFIN(rec) && vertifyCheckSum(rec, &ph))
	{
		cout << "Client: Received packet (FIN, ACK), verification successful.(Second wave)" << endl;
	}
	else 
	{
		return false;
	}

	u_long imode = 0;
	ioctlsocket(sockClient, FIONBIO, &imode);//阻塞

	//第三次挥手，接收确定服务器端的FIN报文

	while (true) 
	{
		recvfrom(sockClient, recBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, &len);

		if (isFIN(rec) && vertifyCheckSum(rec, &ph)) 
		{
			cout << "Client: Received packet (FIN), verification successful.(Third wave)" << endl;
			break;
		}
	}

	imode = 1;
	ioctlsocket(sockClient, FIONBIO, &imode);//非阻塞

	//第四次挥手，发送FIN，ACK报文，FIN=1,ACK=1
	cleanflag(sed);
	setFIN(sed);
	setACK(sed);
	SetCheckSum(sed, &ph);	//设置校验和
	sendto(sockClient, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
	cout << "Client: Sent packet (FIN, ACK) (Fourth wave)" << endl;

	//等待2MSL
	start = clock(); //开始计时

	while (clock() - start <= 2 * MAX_TIME)
	{
		//if(clock() - start>= MAX_TIME)
		if (recvfrom(sockClient, recBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, &len) > 0 && isFIN(rec) && vertifyCheckSum(rec, &ph))
		{
			sendto(sockClient, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
			cout << "Client: Sent packet (FIN, ACK), retransmission(Fourth wave)" << endl;
		}
	}
	cout << "Client: Connection closed" << endl;
	closesocket(sockClient);
	return true;
};

int main() 
{
	//初始化
	ClientInit();
	//建立连接
	if (!establishConnect()) 
	{
		cout << "Fail to connect." << endl;
	}
	while (1) 
	{
		char* filename = new char[100];
		memset(filename, 0, 100);
		string filedir;
		cout << endl;
		cout << "文件编号如下:  " << endl;
		cout << "1: 1.jpg" << endl;
		cout << "2: 2.jpg" << endl;
		cout << "3: 3.jpg" << endl;
		cout << "4: helloworld.txt" << endl;
		cout << "5: a.jpg" << endl;
		cout << "6: Exit" << endl;
		cout << "请输入要传输的文件： " << endl;

		int i;
		cin >> i;
		cout << endl;

		if (i == 6)
		{
			cout << "Exit" << endl;
			break;
		}

		switch (i) 
		{
		case 1:
			filedir = "C:/Users/LENOVO/Desktop/test/1.jpg";
			memcpy(filename, "1.jpg", sizeof("1.jpg"));
			break;

		case 2:
			filedir = "C:/Users/LENOVO/Desktop/test/2.jpg";
			memcpy(filename, "2.jpg", sizeof("2.jpg"));
			break;
		case 3:
			filedir = "C:/Users/LENOVO/Desktop/test/3.jpg";
			memcpy(filename, "3.jpg", sizeof("3.jpg"));
			break;
		case 4:
			filedir = "C:/Users/LENOVO/Desktop/test/helloworld.txt";
			memcpy(filename, "helloworld.txt", sizeof("helloworld.txt"));
			break;
		case 5:
			filedir = "C:/Users/LENOVO/Desktop/test/a.jpg";
			memcpy(filename, "a.jpg", sizeof("a.jpg"));
			break;
		default:
			break;
		}

		ifstream infile(filedir, ifstream::binary);
		if (!infile.is_open()) 
		{
			cout << "Failed to open" << endl;
			return 0;
		}

		infile.seekg(0, infile.end);
		DWORD fileLen = infile.tellg();
		infile.seekg(0, infile.beg);

		cout << "File length : " << fileLen << " Bytes" << endl;

		char* fileBuffer = new char[fileLen];
		infile.read(fileBuffer, fileLen);
		infile.close();

		cout << "Start transmitting file: " << i << endl;

		clock_t start_timer = clock();

		rdt3_send_FSM(fileLen, fileBuffer, filename);

		clock_t end_timer = clock();
		double endtime = (double)(end_timer - start_timer) / CLOCKS_PER_SEC;
		cout << "Total time: " << endtime << " s" << endl;
		cout << "Throughput: " << fileLen * 8 / endtime / 1024 / 1024 << "Mbps" << endl;
	}

	closeConnect();
	WSACleanup();
	return 0;
}