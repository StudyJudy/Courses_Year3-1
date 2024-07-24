#include <iostream>
#include<time.h>
#include<stdio.h>
#include<string>
#include<cstring>
#include<fstream>
#include<math.h>
#include<thread>
#include<iomanip>
#include<WinSock2.h>
#pragma warning(disable:4996)
#pragma comment(lib,"ws2_32.lib")
using namespace std;

typedef unsigned char BYTE;
typedef unsigned short WORD;
typedef unsigned long DWORD;

#define Max_Size 2048
#define MAX_TIME 1000

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

// windows
int N = 32;

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
	SetCheckSum(&message, &ph);	//设校验和
	// 返回构造好的消息结构体
	return message;
}

int base = 1;// 发送窗口的基序号，标识窗口的起始位置，最早的未确认分组序号
int lastseqnum = 1;// 表示最后一个已发送未确认的序号
int nextseqnum;// 表示下一个将要发送的消息的序列号，最小的未使用序号
bool start_t = 0;// 计时器状态
bool rec_stage = 1;// 接收阶段状态
clock_t start_timer;// 计时器
int packet_num;

// 在一个独立的线程中处理确认消息的接收
// GBN 协议中，对序号为 n 的分组的确认采取累积确认（cumulative acknowledgment）
// 表明接收方已正确接收到序号为 n 的以前且包括 n 在内的所有分组
DWORD WINAPI RecHandle(LPVOID param) 
{ 
	// 获取地址结构体的大小
	int len = sizeof(SOCKADDR_IN);

	// 分配用于存储消息的缓冲区
	char* recpktBuffer = new char[sizeof(msg)];

	// 将缓冲区解释为消息结构体
	msg* rec = (msg*)recpktBuffer;

	// 将套接字设置为阻塞模式
	u_long imode = 0;
	ioctlsocket(sockClient, FIONBIO, &imode);//阻塞

	// rec&&notcorrupt(recpkt)
	// 在接收阶段循环执行
	while (rec_stage) 
	{
		// 接收消息并存储在缓冲区中
		recvfrom(sockClient, recpktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, &len);

		// 检查接收到的消息是否是确认消息，且未损坏，且确认号大于等于base(未丢包/超时)
		if (isACK(rec) && vertifyCheckSum(rec, &ph) && (rec->ack_num >= base)) 
		{
			// 收到确认报文时，如果base<=recpkt.ack，设置base=recpkt.ack+1
			base = rec->ack_num + 1;

			// 打印接收到的确认消息的相关信息
			// cout << "接收    " << "ack:    " << rec->ack_num << "       ACK:    " << isACK(rec) << "       length: " << rec->length << "       checksum:       " << rec->checksum << "   base:   " << base << "       lastseqsum:     " << lastseqnum << "       窗口边界:      [" << base << ", " << base + N - 1 << "]" << endl;
			if (base + N + 1 <= packet_num)
			{
				printf("Receive\tACK:\t%d\tack:\t%d\tchecksum:\t%d\tbase: \t%d\tnextseqnum: \t%d\tlength:\t%d\t窗口边界: \t[%d, %d]\n", isACK(rec), rec->ack_num, rec->checksum, base, lastseqnum, rec->length, base, base + N - 1);
				//cout << "接收\tack:\t" << rec->ack_num << "\tACK:\t" << isAck(rec) << "\tlength:\t" << rec->length << "\tchecksum:\t" << rec->checksum << "\tbase: \t" << base << "\tlastseqnum: \t" << lastseqnum << endl;

			//  输出窗口信息，包括窗口边界
			//  cout << "窗口信息 - base: " << base << ", lastseqnum: " << lastseqnum << ", start_t: " << start_t << ", 窗口边界: [" << base << ", " << base + N - 1 << "]" << endl;
				// cout << endl;
			}
			else
			{
				printf("Receive\tACK:\t%d\tack:\t%d\tchecksum:\t%d\tbase: \t%d\tnextseqnum: \t%d\tlength:\t%d\t窗口边界: \t[%d, %d]\n", isACK(rec), rec->ack_num, rec->checksum, base, lastseqnum, rec->length, packet_num - N + 1, packet_num);
				//cout << "接收\tack:\t" << rec->ack_num << "\tACK:\t" << isAck(rec) << "\tlength:\t" << rec->length << "\tchecksum:\t" << rec->checksum << "\tbase: \t" << base << "\tlastseqnum: \t" << lastseqnum << endl;

			//  输出窗口信息，包括窗口边界
			//  cout << "窗口信息 - base: " << base << ", lastseqnum: " << lastseqnum << ", start_t: " << start_t << ", 窗口边界: [" << base << ", " << base + N - 1 << "]" << endl;
				// cout << endl;
			}
						
			// 如果没有未确认的消息，将计时器状态置为0，认为该窗口结束，关闭计时器
			if (base == lastseqnum) 
			{
				start_t = 0;
			}

			// 否则，有未确认的消息，启动计时器，并记录启动时间
			else 
			{
				start_t = 1;
				start_timer = clock();
			}
		}
	}
	// 返回值1表示线程函数的正常退出
	return 1;
}

void GBN_send_FSM(unsigned long length_file, char* file, char* filename, int N) 
{
	// 计算需要发送的数据包数量
	packet_num = int(length_file / Max_Size) + (length_file % Max_Size ? 1 : 0);
	cout << "packet_num: " << packet_num << " " << endl;

	int index = 0;

	int len = sizeof(SOCKADDR_IN);// 获取地址结构体的大小
	int	packetDataLen = min(Max_Size, length_file - index * Max_Size);// 计算每个数据包的长度
	char* dataBuffer = new char[Max_Size];// 分配用于存储数据的缓冲区
	char* pktBuffer = new char[sizeof(msg)];// 分配用于存储发送数据包的缓冲区
	char* recpktBuffer = new char[sizeof(msg)];// 分配用于存储接收确认消息的缓冲区
	msg* rec = (msg*)recpktBuffer;// 将接收缓冲区解释为消息结构体
	msg sndpkt;

	base = 1;//初始化发送窗口的基序号,base为已发送且已确认的序列号
	lastseqnum = 1;// lastseqnum为已发送的最大序列号
	start_t = 0;// 初始化计时器状态

	// 用于标记每个数据包是否第一次发送
	bool* first_send_pkt = new bool[packet_num + 1];
	memset(first_send_pkt, 1, packet_num + 1);
	cout << "本次文件数据长度为 " << length_file << " Bytes, 需要传输 " << packet_num << " 个数据包" << endl;
	
	// 初始化接收阶段标志
	rec_stage = 1;
	
	// 创建用于处理确认消息接收的线程
	HANDLE rechandler = CreateThread(nullptr, 0, RecHandle, nullptr, 0, nullptr);
	
	// GBN发送状态机主循环
	while (1) 
	{
		// 输出窗口信息，包括窗口边界
		// cout << "窗口信息 - base: " << base << ", lastseqnum: " << lastseqnum << ", start_t: " << start_t << ", 窗口边界: [" << base << ", " << base + N - 1 << "]" << endl;

		// 如果已经发送完所有数据包，结束发送
		if (base == packet_num + 1) 
		{
			// 关闭确认消息接收线程
			CloseHandle(rechandler);
			
		    // 结束接收阶段
			rec_stage = 0;
			
			// 将套接字设置为非阻塞模式
			u_long imode = 1;
			ioctlsocket(sockClient, FIONBIO, &imode);//非阻塞
			
			// 分配用于存储发送结束消息的缓冲区
			char* sendBuffer = new char[sizeof(msg)];
			memset(sendBuffer, 0, sizeof(msg));
			
			// 将发送结束消息解释为消息结构体
			msg* sed = (msg*)sendBuffer;
			
			// 设置消息类型为END
			setEND(sed);
			
			// 设置源端口和目标端口
			sed->source_port = port_client;
			sed->dest_port = port_server;
			
			// 将文件名复制到消息的数据字段
			string fn = filename;
			int filename_len = sizeof(fn);
			memcpy(sed->msg, filename, filename_len);
			
			// 设置消息长度
			sed->length = filename_len;
			
			//设置校验和
			SetCheckSum(sed, &ph);	

			// 发送结束消息
			sendto(sockClient, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
			cout << "Client: Send packet (END)" << endl;

			clock_t start_timer = clock(); //开始计时
			
			// 循环等待接收服务器的确认消息
			while (recvfrom(sockClient, recpktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, &len) <= 0 || !(isEND(rec) && isACK(rec)))
			{
				// 超时
				if (clock() - start_timer >= MAX_TIME) 
				{
					//超时重传
					sendto(sockClient, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
					cout << "Client: Send packets (END), retransmit" << endl;
					start_timer = clock();
				}
			}

			// 接收到正确的结束确认消息，文件传输完成
			if (isEND(rec) && isACK(rec) && vertifyCheckSum(rec, &ph)) 
			{
				cout << "Client: The server packet (END, ACK) is received, and the file transfer is completed" << endl;
				return;
			}
			else
				continue;
		}

		// 发送
		// 当nextseqnum小于base+N时，窗口未满，才可以发送报文
		if ((lastseqnum < base + N) && (lastseqnum <= packet_num))
		{
			// 循环发送未发送过的数据包
			for (int i = lastseqnum; (i < base + N) && (i <= packet_num) && first_send_pkt[i]; i++) 
			{
				// 计算数据包在文件中的索引和数据包的长度
				index = i - 1;
				packetDataLen = min(Max_Size, length_file - index * Max_Size);
				
				// 复制数据到数据缓冲区
				memcpy(dataBuffer, file + index * Max_Size, packetDataLen);
				
				// 构造数据包
				sndpkt = make_pkt(i, dataBuffer, packetDataLen);
				
				// 复制数据包到发送缓冲区
				memcpy(pktBuffer, &sndpkt, sizeof(msg));
				
				//  输出窗口信息，包括窗口边界
				// cout << "窗口信息 - base: " << base << ", lastseqnum: " << lastseqnum << ", start_t: " << start_t << ", 窗口边界: [" << base << ", " << base + N - 1 << "]" << endl;

				// 发送数据包
				sendto(sockClient, pktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);			
				nextseqnum = lastseqnum + 1;

				// cout << endl;
				// 输出窗口信息，包括窗口边界
				// cout << "窗口信息 - base: " << base << ", lastseqnum: " << lastseqnum << ", start_t: " << start_t << ", 窗口边界: [" << base << ", " << base + N - 1 << "]" << endl;
				printf("Send\tseq: \t%d\tchecksum: \t%d\tbase: \t%d\tlastseqnum: \t%d\tnextseqnum: \t%d\tlength: \t%d\t\n", i, sndpkt.checksum, base, lastseqnum, nextseqnum, packetDataLen);

				// cout << "发送\tseq:\t" << i << "\tindex:\t" << index << "\tlength:\t" << packetDataLen << "\tchecksum:\t" << sndpkt.checksum << "\tbase: \t" << base << "\tlastseqnum: \t" << lastseqnum << endl;
				// cout << endl;
				
				// 标记第一次已发送但还未确认
				first_send_pkt[i] = 0;
				
				// 开始计时器
				if (base == lastseqnum)
				{
					start_t = 1;
					start_timer = clock();
				}

				// 发送序号为lastseqnum后，lastseqnum++
				lastseqnum++;
				nextseqnum++;
			}
		}

    	// 超时
		// 如果超时，则重传序列号从base到nextseqnum-1的报文（待确认分组），重设计时器
		if ((clock() - start_timer >= MAX_TIME) && start_t == 1) 
		{
			start_timer = clock();
			int lstseqnum = lastseqnum - 1;
			for (int i = base; i < lastseqnum; i++) 
			{
				// 计算数据包在文件中的索引和数据包的长度
				index = i - 1;
				packetDataLen = min(Max_Size, length_file - index * Max_Size);
				memcpy(dataBuffer, file + index * Max_Size, packetDataLen);
				sndpkt = make_pkt(i, dataBuffer, packetDataLen);
				memcpy(pktBuffer, &sndpkt, sizeof(msg));

				sendto(sockClient, pktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
				printf("Send\tseq: \t%d\tchecksum: \t%d\tbase: \t%d\tlastseqnum: \t%d\tnextseqnum: \t%d\tlength: \t%d\t(over time retransmit)\n", i, sndpkt.checksum, base, lstseqnum, lastseqnum, packetDataLen);
				//cout << "发送\tseq:\t" << i << "\tindex:\t" << i-1 << "\tlength:\t" << packetDataLen << "\tchecksum:\t" << sndpkt.checksum << "\tbase: \t" << base << "\tlastseqnum: \t" << lastseqnum <<"\t(重传)" << endl;
			}
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
	cout << endl;

	// int N;
	cout << "Windows： ";
	cin >> N;
	cout << endl;

	while (1) 
	{
		char* filename = new char[100];
		memset(filename, 0, 100);
		string filedir;
		cout << endl;

		cout << "File numbers:  " << endl;
		cout << "1: 1.jpg" << endl;
		cout << "2: 2.jpg" << endl;
		cout << "3: 3.jpg" << endl;
		cout << "4: helloworld.txt" << endl;
		cout << "5: a.jpg" << endl;
		cout << "6: Exit" << endl;
		cout << "Please enter the file number you want to transfer:  " << endl;

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

		GBN_send_FSM(fileLen, fileBuffer, filename, N);

		clock_t end_timer = clock();
		double endtime = (double)(end_timer - start_timer) / CLOCKS_PER_SEC;
		cout << "Total time: " << endtime << " s" << endl;
		cout << "Throughput: " << fileLen * 8 / endtime / 1024 / 1024 << "Mbps" << endl;
	}
	closeConnect();
	WSACleanup();
	return 0;
}
