#include <iostream>
#include<fstream>
#include<WinSock2.h>
#include<time.h>
#include<stdio.h>
#include<string>
#include <cstring>
#include <iomanip>

#pragma warning(disable:4996)
#pragma comment(lib,"ws2_32.lib")
using namespace std;

typedef unsigned char BYTE; // 1字节
typedef unsigned short WORD; // 2字节
typedef unsigned long DWORD; // 4字节

#define  Max_Size 8192
#define MAX_TIME 100

// 定义消息结构体
typedef struct Message
{
	WORD source_port = 0, dest_port = 0;    // 源端口号，目标端口号
	DWORD seq_num = 0, ack_num = 0;         // 序列号，确认号
	WORD length = 0;                        // 数据长度
	BYTE flag = 0;                          // 标志位
	WORD checksum = 0;                      // 校验和
	char msg[Max_Size] = { 0 };             // 数据内容
}msg;

// 定义伪首部结构体
typedef struct UDP_PseudoHead
{
	DWORD source_ip = 0, dest_ip = 0;      // 源IP地址，目标IP地址
	char zero = 0;                          // 填充0
	char protocol = 0;                      // 协议字段
	WORD length = sizeof(msg);              // 长度字段
}psh;

// 设置消息的长度
void setlength(msg* msg, short int len) 
{
	msg->length = len & 0x0004;
}
// 获取消息的长度
short int getlength(msg& msg) 
{
	return msg.length;
}

//ACK=0x01, SYN=0x02, FIN=0x04, END=0x08
// 清除消息的标志位
void cleanflag(msg* msg) 
{
	msg->flag |= 0x0;
}
// 判断消息是否包含 ACK 标志位
bool isAck(msg* msg)
{
	return msg->flag & 0x01;
}
// 判断消息是否包含 SYN 标志位
bool isSyn(msg* msg)
{
	return msg->flag & 0x02;
}
// 判断消息是否包含 FIN 标志位
bool isFin(msg* msg)
{
	return msg->flag & 0x04;
}
// 判断消息是否包含 END 标志位
bool isEnd(msg* msg)
{
	return msg->flag & 0x08;
}
// 设置消息的 ACK 标志位
void setAck(msg* msg) 
{
	msg->flag |= 0x01;
}
// 设置消息的 SYN 标志位
void setSyn(msg* msg) 
{
	msg->flag |= 0x02;
}
// 设置消息的 FIN 标志位
void setFin(msg* msg) 
{
	msg->flag |= 0x04;
}
// 设置消息的 END 标志位
void setEnd(msg* msg) 
{
	msg->flag |= 0x08;
}
// 设置消息的数据内容
void setMsg(msg* msg, char* data) 
{
	memcpy(msg->msg, data, Max_Size);

};
// 设置消息的校验和
void setChecksum(msg* message, psh* ph) 
{
	// 将校验和设为0
	message->checksum = 0;
	int sum = 0;
	int len_pseudo = sizeof(psh);
	int len_msg = sizeof(msg);

	// 计算伪首部的校验和
	for (int i = 0; i < len_pseudo / 2; i++) 
	{
		sum += ((WORD*)ph)[i];
	}
	//计算消息部分的校验和,如果有进位，就将进位部分加回到sum的低16位中。
	for (int i = 0; i < len_msg / 2; i++) 
	{
		sum += ((WORD*)message)[i];
	}
	// 处理溢出位
	while (sum >> 16) 
	{
		sum = (sum & 0xFFFF) + (sum >> 16);
	}
	// 将校验和取反赋值给消息
	message->checksum = ~sum;
};

// 验证消息的校验和
bool vertifyChecksum(msg* message, psh* ph) 
{
	int sum = 0;
	int len_pseudo = sizeof(psh);
	int len_msg = sizeof(msg);

	// 计算伪首部的校验和
	for (int i = 0; i < len_pseudo / 2; i++) 
	{
		sum += ((WORD*)ph)[i];
	}
	// 计算消息部分的校验和,如果有进位，就将进位部分加回到sum的低16位中。
	for (int i = 0; i < len_msg / 2; i++) 
	{
		sum += ((WORD*)message)[i];
	}
	// 处理溢出位
	while (sum >> 16) 
	{
		sum = (sum & 0xFFFF) + (sum >> 16);
	}
	// 验证校验和是否为0xFFFF
	return sum == 0xFFFF;
};

char  ip_client[] = "127.0.0.1";
WORD  port_client = 7777;
char ip_server[] = "127.0.0.1";
WORD  port_server = 8888;

char ip_route[] = "127.0.0.1";
WORD  port_route = 9999;
psh ph;		//伪首部

SOCKET sockServer;
SOCKADDR_IN addr_client;
SOCKADDR_IN addr_server;

void ServerInit() 
{
	//Startup
	WSADATA wsadata;
	int res;
	res = WSAStartup(MAKEWORD(2, 2), &wsadata);
	if (res != 0) 
	{
		cout << "Startup failed.Err: " << GetLastError() << endl;
		return;
	}
	else
	{
		cout << "Startup success!" << endl;
	}

	// 配置客户端和服务器地址
	addr_client.sin_port = htons(port_route);					// 端口
	addr_client.sin_addr.S_un.S_addr = inet_addr(ip_route); // IP 地址
	addr_client.sin_family = AF_INET;

	addr_server.sin_port = htons(port_server);
	addr_server.sin_addr.S_un.S_addr = inet_addr(ip_server);
	addr_server.sin_family = AF_INET;

	// 创建套接字
	sockServer = socket(AF_INET, SOCK_DGRAM, 0);
	if (sockServer == INVALID_SOCKET) 
	{
		cout << "Socket create failed. Err: " << GetLastError() << endl;
		return;
	}

	// 绑定套接字
	int result_bind;
	result_bind = bind(sockServer, (SOCKADDR*)&addr_server, sizeof(SOCKADDR_IN));
	if (result_bind == SOCKET_ERROR) 
	{
		cout << "Bind failed. Err: " << GetLastError() << endl;
		return;
	}

	//初始化伪首部
	memset(&ph, 0, sizeof(psh));
	ph.source_ip = inet_addr(ip_client);
	ph.dest_ip = inet_addr(ip_server);

	cout << "Initialization successful. Server is now connecting" << endl;
}

bool establishConnect() 
{
	int len = sizeof(SOCKADDR_IN);

	char recBuffer[sizeof(msg)];	//接收缓冲区
	char sendBuffer[sizeof(msg)];	//发送缓冲区

	msg* sed = (msg*)sendBuffer;
	msg* rec = (msg*)recBuffer;

	memset(recBuffer, 0, sizeof(msg));
	memset(sendBuffer, 0, sizeof(msg));

	while (1) 
	{
		//cout << "here" << endl;
		//第一次握手接收SYN
		recvfrom(sockServer, recBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, &len);

		if (isSyn(rec) && vertifyChecksum(rec, &ph) && rec->seq_num == 0) 
		{
			cout << "Server: Received packet (SYN) validation successful! (First Shake)" << endl;

			//第二次握手设置SYN，ACK报文，SYN=1，ACK=1，seq=0，ack=1
			setAck(sed);
			setSyn(sed);
			sed->seq_num = 0;
			sed->ack_num = 1;
			sed->source_port = port_server;
			sed->dest_port = port_client;
			setChecksum(sed, &ph);

			//发送SYN，ACK
			sendto(sockServer, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, len);
			cout << "Server: Send packet (SYN,ACK) (Second Shake)" << endl;
			break;
		}
		else 
		{
			cout << "Server: Received packet (SYN) validation failed." << endl;
			continue;
		}
	}

	//设为非阻塞
	u_long imode = 1;
	ioctlsocket(sockServer, FIONBIO, &imode);//非阻塞

	clock_t start = clock(); //开始计时
	while (recvfrom(sockServer, recBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, &len) <= 0) 
	{
		if (clock() - start >= MAX_TIME)
		{
			//超时重传
			sendto(sockServer, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, len);
			cout << "Server: Resend packet (SYN,ACK) (Second Shake）..." << endl;
			start = clock();
		}
	}
	//第三次握手
	if (isAck(rec) && vertifyChecksum(rec, &ph)) 
	{
		cout << "Server: Received packet (ACK) validation successful! (Third Shake)" << endl;
	}
	else
	{
		return false;
	}
	imode = 0;
	ioctlsocket(sockServer, FIONBIO, &imode);//阻塞
	return true;
}

//源自于应用程序的报文分组打包成报文段
msg make_pkt(int ack) 
{
	msg message;
	memset(&message, 0, sizeof(msg));

	// 设置源端口和目标端口
	message.source_port = port_client;
	message.dest_port = port_server;

	setAck(&message);// 设置ACK标志
	message.ack_num = ack;// 设置ACK号

	psh ph;		//伪首部
	memset(&ph, 0, sizeof(psh));

	// 设置伪首部的源IP和目标IP
	ph.source_ip = inet_addr(ip_client);
	ph.dest_ip = inet_addr(ip_server);
	setChecksum(&message, &ph);	//设置校验和
	return message;// 返回构造的消息结构体
}
// 路由：客户端发来的包，进行丢包、延时处理后发向服务器端
// 接收状态机函数，用于处理服务器端接收文件的过程
DWORD rdt3_receive_FSM(char* file, char* filename) 
{
	int count = 0;// 数据包序号
	int state = 0;// 状态机阶段

	int len = sizeof(SOCKADDR_IN);

	char* pktBuffer = new char[sizeof(msg)]; // 接收缓冲区
	char* recpktBuffer = new char[sizeof(msg)]; // 接收到的数据包缓冲区
	char* sendBuffer = new char[sizeof(msg)]; // 发送缓冲区

	DWORD rec_data_len = 0;// 已接收数据长度
	msg* rec = (msg*)recpktBuffer;// 解析接收到的数据包
	u_long imode = 0;

	//if (ioctlsocket(sockServer, FIONBIO, &imode) == SOCKET_ERROR)
	//	cout << "error" << endl;

	bool start_tran = 0;// 标志文件传输是否开始
	while (true) 
	{
		memset(recpktBuffer, 0, sizeof(msg));// 清空接收数据包缓冲区

		switch (state) 
		{
		/*
		接收来自客户端的数据包。
        如果接收到序号为2的数据包且校验和通过，发送ACK为2的确认；
        如果接收到序号为3的数据包或校验和不通过，发送ACK为3的确认。
		*/
		case 0:
			// rdt3.0: 下层通过rdt_rcv方法，将数据推送到传输层
			if (recvfrom(sockServer, recpktBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, &len) > 0 && rec->length == 0)
			{
				break;
			}
			// 接收到结束标志且文件传输已开始，传输结束
			if (isEnd(rec) && start_tran) 
			{
				//将文件名拷贝到 filename 中
				memcpy(filename, rec->msg, rec->length);
				cout << "Transmission complete." << endl;
				memset(sendBuffer, 0, sizeof(msg));
				msg sed = make_pkt(0);

				//发送包含结束标志的确认报文（END，ACK），返回已接收数据的长度。
				setEnd(&sed);
				sed.checksum = 0;
				setChecksum(&sed, &ph);

				memcpy(sendBuffer, &sed, sizeof(msg));
				sendto(sockServer, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, len);
				cout << "Server: sends the packet (END, ACK)" << endl;
				return rec_data_len;// 返回已接收数据的长度
			}

			// rdt3.0: 接收到序号为3的数据包或校验和不通过
			if (rec->seq_num == 3 || !(vertifyChecksum(rec, &ph))) 
			{
				msg sedpkt = make_pkt(3);
				memcpy(sendBuffer, &sedpkt, sizeof(msg));

				//rdt3.0: 发送缓存区数据序号的确认ACK指令
				//发送一个带有ack为3的确认报文，输出相应的状态信息，并保持在阶段0，告知发送端数据包有误。
				sendto(sockServer, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, len);
				cout << "Case 0: State 0-Received     " << std::setw(20) << std::left << "seq: 3 " << endl;
				cout << "Case 0: State 0-Sent         " << std::setw(20) << std::left << "ack: 3" << "ACK : " << std::setw(20) << std::left << isAck(&sedpkt) << "  length : " << std::setw(20) << std::left << sedpkt.length << " checksum : " << std::setw(20) << std::left << sedpkt.checksum << std::setw(20) << std::left << "WRONG!" << endl;			
				cout << endl;
				state = 0;//rdt 3.0: 保持等待下层调用的状态
				break;
			}

			//rdt3.0: 接收到的数据包的序号是2且校验和通过，则正确接收
			if (rec->seq_num == 2 && (vertifyChecksum(rec, &ph))) 
			{
				//rdt 3.0: 数据置换到缓存区中
				msg sedpkt = make_pkt(2);
				memcpy(sendBuffer, &sedpkt, sizeof(msg));

				//rdt 3.0: 发送一个带有ACK为2的确认报文
				sendto(sockServer, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, len);
				cout << "Case 0: State 0-Received     "<< std::setw(20) << std::left<<"seq: 2"<< "count : " << std::setw(20) << std::left << count << "length : " << std::setw(20) << std::left << rec->length << " checksum : " << std::setw(20) << std::left << rec->checksum << endl;
				cout << "Case 0: State 0-Sent         " << std::setw(20) << std::left << "ack: 2" << "ACK : " << std::setw(20) << std::left << isAck(&sedpkt) << "  length : " << std::setw(20) << std::left << sedpkt.length << " checksum : " << std::setw(20) << std::left << sedpkt.checksum << std::setw(20) << std::left << "BINGO!" << endl;
				cout << endl;

				memcpy(file + rec_data_len, rec->msg, rec->length);//将数据写入文件
				rec_data_len += rec->length;//记录接收数据的长度
				state = 1;//切换到state1
				start_tran = 1;//标记文件传输已开始
				count++;
				break;
			}
			break;
		/*
		接收来自客户端的数据包。
        如果接收到序号为3的数据包且校验和通过，发送ACK为3的确认；如果接收到序号为2的数据包或校验和不通过，发送ACK为2的确认。
        如果接收到结束标志，传输结束，将文件名拷贝到filename中。
		*/
		case 1:
			// rdt3.0: 下层通过rdt_rcv方法，将数据推送到传输层
			recvfrom(sockServer, recpktBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, &len);
			// 接收到结束标志且文件传输已开始，传输结束
			if (isEnd(rec) && start_tran) 
			{
				//将文件名拷贝到 filename 中
				memcpy(filename, rec->msg, rec->length);
				cout << "Transmission complete." << endl;
				memset(sendBuffer, 0, sizeof(msg));
				msg sed = make_pkt(0);

				//发送包含结束标志的确认报文（END，ACK），返回已接收数据的长度
				setEnd(&sed);
				sed.checksum = 0;
				setChecksum(&sed, &ph);

				memcpy(sendBuffer, &sed, sizeof(msg));
				sendto(sockServer, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, len);
				return rec_data_len;// 返回已接收数据的长度
			}
			// rdt3.0: 接收到序号为2的数据包或校验和不通过
			if (rec->seq_num == 2 || !(vertifyChecksum(rec, &ph))) 
			{
				
				msg sedpkt = make_pkt(2);
				memcpy(sendBuffer, &sedpkt, sizeof(msg));
				//rdt3.0: 发送缓存区数据序号的确认ACK指令
				//rdt3.0: 发送一个带有ack为2的确认报文，输出相应的状态信息，并保持在阶段1，告知发送端数据包有误。
				sendto(sockServer, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, len);

				cout << "Case 1: State 1-Received     "<< std::setw(20) << std::left<<"seq: 2 " << std::setw(20) << std::left << endl;
				cout << "Case 1: State 1-Sent        " << std::setw(20) << std::left << " ack: 2" << " ACK : " << std::setw(20) << std::left << isAck(&sedpkt) << "  length : " << std::setw(20) << std::left << sedpkt.length << " checksum : " << std::setw(20) << std::left << sedpkt.checksum << std::setw(20) << std::left << "WRONG!" << endl;
				cout << endl;

				state = 1;// 保持在状态1
				break;
			}
			//rdt3.0: 接收到序号为3的数据包且校验和通过
			if (rec->seq_num == 3 && (vertifyChecksum(rec, &ph)))
			{
				
				//rdt 3.0: 数据置换到缓存区中
				msg sedpkt = make_pkt(3);
				memcpy(sendBuffer, &sedpkt, sizeof(msg));

				//rdt 3.0: 发送一个带有ACK为3的确认报文
				sendto(sockServer, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, len);

				cout << "Case 1: State 1-Received     " << std::setw(20) << std::left<<"seq: 3" <<"count : " << std::setw(20) << std::left << count << "length : " << std::setw(20) << std::left << rec->length << " checksum : " << std::setw(20) << std::left << rec->checksum << endl;
				cout << "Case 1: State 1-Sent         " << std::setw(20) << std::left << "ack: 3" << "ACK : " << std::setw(20) << std::left << isAck(&sedpkt) << "  length : " << std::setw(20) << std::left << sedpkt.length << " checksum : " << std::setw(20) << std::left << sedpkt.checksum << std::setw(20) << std::left << "BINGO!" << endl;
				cout << endl;

				memcpy(file + rec_data_len, rec->msg, rec->length); //将数据写入文件
				rec_data_len += rec->length;//记录接收数据的长度
				start_tran = 1;// 文件传输已开始
				state = 0;// 切换到阶段0
				count++;
				break;
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

	u_long imode = 0;
	ioctlsocket(sockServer, FIONBIO, &imode);//阻塞

	//第一次挥手，接收验证客户端的FIN报文
	while (1) 
	{
		recvfrom(sockServer, recBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, &len);

		if (isFin(rec) && vertifyChecksum(rec, &ph)) 
		{
			cout << "Server: Received packet(FIN),vertification is successful.(First wave)" << endl;
			break;
		}
	}

	//第二次挥手：服务器设置发送ACK，FIN报文，FIN=1,ACK=1,seq=0,ack=0

	setFin(sed);		//设置Fin
	setAck(sed);		//设置Ack
	sed->seq_num = 0;	//设置seq=0
	sed->ack_num = 0;	//设置ack=0
	sed->source_port = port_client;
	sed->dest_port = port_server;
	setChecksum(sed, &ph);	//设置校验和

	//发送
	sendto(sockServer, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, len);
	cout << "Server:Sent packet (FIN, ACK), verification successful.(Second wave)" << endl;

	//第三次挥手发送FIN FIN=1
	cleanflag(sed);
	setFin(sed);		//设置Fin
	setChecksum(sed, &ph);
	sendto(sockServer, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, len);
	cout << "Server:Sent packet (FIN), verification successful.(Third wave)" << endl;

	imode = 1;
	ioctlsocket(sockServer, FIONBIO, &imode);//非阻塞

	//第三次挥手接收
	clock_t  start = clock(); //开始计时

	while (recvfrom(sockServer, recBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, &len) <= 0 || !(isAck(rec) && isFin(rec) && vertifyChecksum(rec, &ph))) 
	{
		if (clock() - start >= MAX_TIME)
		{
			//超时重传
			sendto(sockServer, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, len);
			cout << "Server: Sent packet (FIN), retransmission" << endl;
			start = clock();
		}
	}
	//第四次挥手
	if (isAck(rec) && isFin(rec) && vertifyChecksum(rec, &ph)) 
	{
		cout << "Server: Received packet (FIN, ACK), verification successful.(Fourth wave)" << endl;
	}
	else 
	{
		return false;
	}
	cout << "Connection close..." << endl;
	closesocket(sockServer);
	return true;
};

int main()
{

	ServerInit();
	if (establishConnect())
	{
		cout << "Server: connection is established successfully" << endl;
	}
	cout << endl;

	//接收文件的缓冲区
	bool tran = 1;

	while (tran) 
	{
		char* fileBuffer = new char[100000000];

		DWORD fileLength = 0;
		char* filename = new char[100];
		memset(filename, 0, 100);

		fileLength = rdt3_receive_FSM(fileBuffer, filename);

		cout << endl;

		string dir = "C:/Users/LENOVO/Desktop/test/recv/";
		string fn = filename;
		string filenm = dir + fn;

		//写入复制文件
		ofstream outfile(filenm, ios::binary);
		outfile.write(fileBuffer, fileLength);
		outfile.close();

		cout << "Y/N: ";
		char i;
		cin >> i;

		cout << endl;
		switch (i)
		{
		case 'y':
			tran = 1;
			break;
		case 'n':
			tran = 0;
			break;

		default:
			break;
		}
	}
	closeConnect();
	WSACleanup();
	return 0;
}