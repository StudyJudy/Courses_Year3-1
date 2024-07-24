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

typedef unsigned char BYTE; // 1�ֽ�
typedef unsigned short WORD; // 2�ֽ�
typedef unsigned long DWORD; // 4�ֽ�

#define  Max_Size 8192
#define MAX_TIME 100

// ������Ϣ�ṹ��
typedef struct Message
{
	WORD source_port = 0, dest_port = 0;    // Դ�˿ںţ�Ŀ��˿ں�
	DWORD seq_num = 0, ack_num = 0;         // ���кţ�ȷ�Ϻ�
	WORD length = 0;                        // ���ݳ���
	BYTE flag = 0;                          // ��־λ
	WORD checksum = 0;                      // У���
	char msg[Max_Size] = { 0 };             // ��������
}msg;

// ����α�ײ��ṹ��
typedef struct UDP_PseudoHead
{
	DWORD source_ip = 0, dest_ip = 0;      // ԴIP��ַ��Ŀ��IP��ַ
	char zero = 0;                          // ���0
	char protocol = 0;                      // Э���ֶ�
	WORD length = sizeof(msg);              // �����ֶ�
}psh;

// ������Ϣ�ĳ���
void setlength(msg* msg, short int len) 
{
	msg->length = len & 0x0004;
}
// ��ȡ��Ϣ�ĳ���
short int getlength(msg& msg) 
{
	return msg.length;
}

//ACK=0x01, SYN=0x02, FIN=0x04, END=0x08
// �����Ϣ�ı�־λ
void cleanflag(msg* msg) 
{
	msg->flag |= 0x0;
}
// �ж���Ϣ�Ƿ���� ACK ��־λ
bool isAck(msg* msg)
{
	return msg->flag & 0x01;
}
// �ж���Ϣ�Ƿ���� SYN ��־λ
bool isSyn(msg* msg)
{
	return msg->flag & 0x02;
}
// �ж���Ϣ�Ƿ���� FIN ��־λ
bool isFin(msg* msg)
{
	return msg->flag & 0x04;
}
// �ж���Ϣ�Ƿ���� END ��־λ
bool isEnd(msg* msg)
{
	return msg->flag & 0x08;
}
// ������Ϣ�� ACK ��־λ
void setAck(msg* msg) 
{
	msg->flag |= 0x01;
}
// ������Ϣ�� SYN ��־λ
void setSyn(msg* msg) 
{
	msg->flag |= 0x02;
}
// ������Ϣ�� FIN ��־λ
void setFin(msg* msg) 
{
	msg->flag |= 0x04;
}
// ������Ϣ�� END ��־λ
void setEnd(msg* msg) 
{
	msg->flag |= 0x08;
}
// ������Ϣ����������
void setMsg(msg* msg, char* data) 
{
	memcpy(msg->msg, data, Max_Size);

};
// ������Ϣ��У���
void setChecksum(msg* message, psh* ph) 
{
	// ��У�����Ϊ0
	message->checksum = 0;
	int sum = 0;
	int len_pseudo = sizeof(psh);
	int len_msg = sizeof(msg);

	// ����α�ײ���У���
	for (int i = 0; i < len_pseudo / 2; i++) 
	{
		sum += ((WORD*)ph)[i];
	}
	//������Ϣ���ֵ�У���,����н�λ���ͽ���λ���ּӻص�sum�ĵ�16λ�С�
	for (int i = 0; i < len_msg / 2; i++) 
	{
		sum += ((WORD*)message)[i];
	}
	// �������λ
	while (sum >> 16) 
	{
		sum = (sum & 0xFFFF) + (sum >> 16);
	}
	// ��У���ȡ����ֵ����Ϣ
	message->checksum = ~sum;
};

// ��֤��Ϣ��У���
bool vertifyChecksum(msg* message, psh* ph) 
{
	int sum = 0;
	int len_pseudo = sizeof(psh);
	int len_msg = sizeof(msg);

	// ����α�ײ���У���
	for (int i = 0; i < len_pseudo / 2; i++) 
	{
		sum += ((WORD*)ph)[i];
	}
	// ������Ϣ���ֵ�У���,����н�λ���ͽ���λ���ּӻص�sum�ĵ�16λ�С�
	for (int i = 0; i < len_msg / 2; i++) 
	{
		sum += ((WORD*)message)[i];
	}
	// �������λ
	while (sum >> 16) 
	{
		sum = (sum & 0xFFFF) + (sum >> 16);
	}
	// ��֤У����Ƿ�Ϊ0xFFFF
	return sum == 0xFFFF;
};

char  ip_client[] = "127.0.0.1";
WORD  port_client = 7777;
char ip_server[] = "127.0.0.1";
WORD  port_server = 8888;

char ip_route[] = "127.0.0.1";
WORD  port_route = 9999;
psh ph;		//α�ײ�

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

	// ���ÿͻ��˺ͷ�������ַ
	addr_client.sin_port = htons(port_route);					// �˿�
	addr_client.sin_addr.S_un.S_addr = inet_addr(ip_route); // IP ��ַ
	addr_client.sin_family = AF_INET;

	addr_server.sin_port = htons(port_server);
	addr_server.sin_addr.S_un.S_addr = inet_addr(ip_server);
	addr_server.sin_family = AF_INET;

	// �����׽���
	sockServer = socket(AF_INET, SOCK_DGRAM, 0);
	if (sockServer == INVALID_SOCKET) 
	{
		cout << "Socket create failed. Err: " << GetLastError() << endl;
		return;
	}

	// ���׽���
	int result_bind;
	result_bind = bind(sockServer, (SOCKADDR*)&addr_server, sizeof(SOCKADDR_IN));
	if (result_bind == SOCKET_ERROR) 
	{
		cout << "Bind failed. Err: " << GetLastError() << endl;
		return;
	}

	//��ʼ��α�ײ�
	memset(&ph, 0, sizeof(psh));
	ph.source_ip = inet_addr(ip_client);
	ph.dest_ip = inet_addr(ip_server);

	cout << "Initialization successful. Server is now connecting" << endl;
}

bool establishConnect() 
{
	int len = sizeof(SOCKADDR_IN);

	char recBuffer[sizeof(msg)];	//���ջ�����
	char sendBuffer[sizeof(msg)];	//���ͻ�����

	msg* sed = (msg*)sendBuffer;
	msg* rec = (msg*)recBuffer;

	memset(recBuffer, 0, sizeof(msg));
	memset(sendBuffer, 0, sizeof(msg));

	while (1) 
	{
		//cout << "here" << endl;
		//��һ�����ֽ���SYN
		recvfrom(sockServer, recBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, &len);

		if (isSyn(rec) && vertifyChecksum(rec, &ph) && rec->seq_num == 0) 
		{
			cout << "Server: Received packet (SYN) validation successful! (First Shake)" << endl;

			//�ڶ�����������SYN��ACK���ģ�SYN=1��ACK=1��seq=0��ack=1
			setAck(sed);
			setSyn(sed);
			sed->seq_num = 0;
			sed->ack_num = 1;
			sed->source_port = port_server;
			sed->dest_port = port_client;
			setChecksum(sed, &ph);

			//����SYN��ACK
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

	//��Ϊ������
	u_long imode = 1;
	ioctlsocket(sockServer, FIONBIO, &imode);//������

	clock_t start = clock(); //��ʼ��ʱ
	while (recvfrom(sockServer, recBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, &len) <= 0) 
	{
		if (clock() - start >= MAX_TIME)
		{
			//��ʱ�ش�
			sendto(sockServer, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, len);
			cout << "Server: Resend packet (SYN,ACK) (Second Shake��..." << endl;
			start = clock();
		}
	}
	//����������
	if (isAck(rec) && vertifyChecksum(rec, &ph)) 
	{
		cout << "Server: Received packet (ACK) validation successful! (Third Shake)" << endl;
	}
	else
	{
		return false;
	}
	imode = 0;
	ioctlsocket(sockServer, FIONBIO, &imode);//����
	return true;
}

//Դ����Ӧ�ó���ı��ķ������ɱ��Ķ�
msg make_pkt(int ack) 
{
	msg message;
	memset(&message, 0, sizeof(msg));

	// ����Դ�˿ں�Ŀ��˿�
	message.source_port = port_client;
	message.dest_port = port_server;

	setAck(&message);// ����ACK��־
	message.ack_num = ack;// ����ACK��

	psh ph;		//α�ײ�
	memset(&ph, 0, sizeof(psh));

	// ����α�ײ���ԴIP��Ŀ��IP
	ph.source_ip = inet_addr(ip_client);
	ph.dest_ip = inet_addr(ip_server);
	setChecksum(&message, &ph);	//����У���
	return message;// ���ع������Ϣ�ṹ��
}
// ·�ɣ��ͻ��˷����İ������ж�������ʱ��������������
// ����״̬�����������ڴ���������˽����ļ��Ĺ���
DWORD rdt3_receive_FSM(char* file, char* filename) 
{
	int count = 0;// ���ݰ����
	int state = 0;// ״̬���׶�

	int len = sizeof(SOCKADDR_IN);

	char* pktBuffer = new char[sizeof(msg)]; // ���ջ�����
	char* recpktBuffer = new char[sizeof(msg)]; // ���յ������ݰ�������
	char* sendBuffer = new char[sizeof(msg)]; // ���ͻ�����

	DWORD rec_data_len = 0;// �ѽ������ݳ���
	msg* rec = (msg*)recpktBuffer;// �������յ������ݰ�
	u_long imode = 0;

	//if (ioctlsocket(sockServer, FIONBIO, &imode) == SOCKET_ERROR)
	//	cout << "error" << endl;

	bool start_tran = 0;// ��־�ļ������Ƿ�ʼ
	while (true) 
	{
		memset(recpktBuffer, 0, sizeof(msg));// ��ս������ݰ�������

		switch (state) 
		{
		/*
		�������Կͻ��˵����ݰ���
        ������յ����Ϊ2�����ݰ���У���ͨ��������ACKΪ2��ȷ�ϣ�
        ������յ����Ϊ3�����ݰ���У��Ͳ�ͨ��������ACKΪ3��ȷ�ϡ�
		*/
		case 0:
			// rdt3.0: �²�ͨ��rdt_rcv���������������͵������
			if (recvfrom(sockServer, recpktBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, &len) > 0 && rec->length == 0)
			{
				break;
			}
			// ���յ�������־���ļ������ѿ�ʼ���������
			if (isEnd(rec) && start_tran) 
			{
				//���ļ��������� filename ��
				memcpy(filename, rec->msg, rec->length);
				cout << "Transmission complete." << endl;
				memset(sendBuffer, 0, sizeof(msg));
				msg sed = make_pkt(0);

				//���Ͱ���������־��ȷ�ϱ��ģ�END��ACK���������ѽ������ݵĳ��ȡ�
				setEnd(&sed);
				sed.checksum = 0;
				setChecksum(&sed, &ph);

				memcpy(sendBuffer, &sed, sizeof(msg));
				sendto(sockServer, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, len);
				cout << "Server: sends the packet (END, ACK)" << endl;
				return rec_data_len;// �����ѽ������ݵĳ���
			}

			// rdt3.0: ���յ����Ϊ3�����ݰ���У��Ͳ�ͨ��
			if (rec->seq_num == 3 || !(vertifyChecksum(rec, &ph))) 
			{
				msg sedpkt = make_pkt(3);
				memcpy(sendBuffer, &sedpkt, sizeof(msg));

				//rdt3.0: ���ͻ�����������ŵ�ȷ��ACKָ��
				//����һ������ackΪ3��ȷ�ϱ��ģ������Ӧ��״̬��Ϣ���������ڽ׶�0����֪���Ͷ����ݰ�����
				sendto(sockServer, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, len);
				cout << "Case 0: State 0-Received     " << std::setw(20) << std::left << "seq: 3 " << endl;
				cout << "Case 0: State 0-Sent         " << std::setw(20) << std::left << "ack: 3" << "ACK : " << std::setw(20) << std::left << isAck(&sedpkt) << "  length : " << std::setw(20) << std::left << sedpkt.length << " checksum : " << std::setw(20) << std::left << sedpkt.checksum << std::setw(20) << std::left << "WRONG!" << endl;			
				cout << endl;
				state = 0;//rdt 3.0: ���ֵȴ��²���õ�״̬
				break;
			}

			//rdt3.0: ���յ������ݰ��������2��У���ͨ��������ȷ����
			if (rec->seq_num == 2 && (vertifyChecksum(rec, &ph))) 
			{
				//rdt 3.0: �����û�����������
				msg sedpkt = make_pkt(2);
				memcpy(sendBuffer, &sedpkt, sizeof(msg));

				//rdt 3.0: ����һ������ACKΪ2��ȷ�ϱ���
				sendto(sockServer, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, len);
				cout << "Case 0: State 0-Received     "<< std::setw(20) << std::left<<"seq: 2"<< "count : " << std::setw(20) << std::left << count << "length : " << std::setw(20) << std::left << rec->length << " checksum : " << std::setw(20) << std::left << rec->checksum << endl;
				cout << "Case 0: State 0-Sent         " << std::setw(20) << std::left << "ack: 2" << "ACK : " << std::setw(20) << std::left << isAck(&sedpkt) << "  length : " << std::setw(20) << std::left << sedpkt.length << " checksum : " << std::setw(20) << std::left << sedpkt.checksum << std::setw(20) << std::left << "BINGO!" << endl;
				cout << endl;

				memcpy(file + rec_data_len, rec->msg, rec->length);//������д���ļ�
				rec_data_len += rec->length;//��¼�������ݵĳ���
				state = 1;//�л���state1
				start_tran = 1;//����ļ������ѿ�ʼ
				count++;
				break;
			}
			break;
		/*
		�������Կͻ��˵����ݰ���
        ������յ����Ϊ3�����ݰ���У���ͨ��������ACKΪ3��ȷ�ϣ�������յ����Ϊ2�����ݰ���У��Ͳ�ͨ��������ACKΪ2��ȷ�ϡ�
        ������յ�������־��������������ļ���������filename�С�
		*/
		case 1:
			// rdt3.0: �²�ͨ��rdt_rcv���������������͵������
			recvfrom(sockServer, recpktBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, &len);
			// ���յ�������־���ļ������ѿ�ʼ���������
			if (isEnd(rec) && start_tran) 
			{
				//���ļ��������� filename ��
				memcpy(filename, rec->msg, rec->length);
				cout << "Transmission complete." << endl;
				memset(sendBuffer, 0, sizeof(msg));
				msg sed = make_pkt(0);

				//���Ͱ���������־��ȷ�ϱ��ģ�END��ACK���������ѽ������ݵĳ���
				setEnd(&sed);
				sed.checksum = 0;
				setChecksum(&sed, &ph);

				memcpy(sendBuffer, &sed, sizeof(msg));
				sendto(sockServer, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, len);
				return rec_data_len;// �����ѽ������ݵĳ���
			}
			// rdt3.0: ���յ����Ϊ2�����ݰ���У��Ͳ�ͨ��
			if (rec->seq_num == 2 || !(vertifyChecksum(rec, &ph))) 
			{
				
				msg sedpkt = make_pkt(2);
				memcpy(sendBuffer, &sedpkt, sizeof(msg));
				//rdt3.0: ���ͻ�����������ŵ�ȷ��ACKָ��
				//rdt3.0: ����һ������ackΪ2��ȷ�ϱ��ģ������Ӧ��״̬��Ϣ���������ڽ׶�1����֪���Ͷ����ݰ�����
				sendto(sockServer, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, len);

				cout << "Case 1: State 1-Received     "<< std::setw(20) << std::left<<"seq: 2 " << std::setw(20) << std::left << endl;
				cout << "Case 1: State 1-Sent        " << std::setw(20) << std::left << " ack: 2" << " ACK : " << std::setw(20) << std::left << isAck(&sedpkt) << "  length : " << std::setw(20) << std::left << sedpkt.length << " checksum : " << std::setw(20) << std::left << sedpkt.checksum << std::setw(20) << std::left << "WRONG!" << endl;
				cout << endl;

				state = 1;// ������״̬1
				break;
			}
			//rdt3.0: ���յ����Ϊ3�����ݰ���У���ͨ��
			if (rec->seq_num == 3 && (vertifyChecksum(rec, &ph)))
			{
				
				//rdt 3.0: �����û�����������
				msg sedpkt = make_pkt(3);
				memcpy(sendBuffer, &sedpkt, sizeof(msg));

				//rdt 3.0: ����һ������ACKΪ3��ȷ�ϱ���
				sendto(sockServer, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, len);

				cout << "Case 1: State 1-Received     " << std::setw(20) << std::left<<"seq: 3" <<"count : " << std::setw(20) << std::left << count << "length : " << std::setw(20) << std::left << rec->length << " checksum : " << std::setw(20) << std::left << rec->checksum << endl;
				cout << "Case 1: State 1-Sent         " << std::setw(20) << std::left << "ack: 3" << "ACK : " << std::setw(20) << std::left << isAck(&sedpkt) << "  length : " << std::setw(20) << std::left << sedpkt.length << " checksum : " << std::setw(20) << std::left << sedpkt.checksum << std::setw(20) << std::left << "BINGO!" << endl;
				cout << endl;

				memcpy(file + rec_data_len, rec->msg, rec->length); //������д���ļ�
				rec_data_len += rec->length;//��¼�������ݵĳ���
				start_tran = 1;// �ļ������ѿ�ʼ
				state = 0;// �л����׶�0
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
	char recBuffer[sizeof(msg)];	//���ջ�����
	char sendBuffer[sizeof(msg)];	//���ͻ�����
	memset(recBuffer, 0, sizeof(msg));
	memset(sendBuffer, 0, sizeof(msg));

	msg* sed = (msg*)sendBuffer;
	msg* rec = (msg*)recBuffer;

	u_long imode = 0;
	ioctlsocket(sockServer, FIONBIO, &imode);//����

	//��һ�λ��֣�������֤�ͻ��˵�FIN����
	while (1) 
	{
		recvfrom(sockServer, recBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, &len);

		if (isFin(rec) && vertifyChecksum(rec, &ph)) 
		{
			cout << "Server: Received packet(FIN),vertification is successful.(First wave)" << endl;
			break;
		}
	}

	//�ڶ��λ��֣����������÷���ACK��FIN���ģ�FIN=1,ACK=1,seq=0,ack=0

	setFin(sed);		//����Fin
	setAck(sed);		//����Ack
	sed->seq_num = 0;	//����seq=0
	sed->ack_num = 0;	//����ack=0
	sed->source_port = port_client;
	sed->dest_port = port_server;
	setChecksum(sed, &ph);	//����У���

	//����
	sendto(sockServer, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, len);
	cout << "Server:Sent packet (FIN, ACK), verification successful.(Second wave)" << endl;

	//�����λ��ַ���FIN FIN=1
	cleanflag(sed);
	setFin(sed);		//����Fin
	setChecksum(sed, &ph);
	sendto(sockServer, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, len);
	cout << "Server:Sent packet (FIN), verification successful.(Third wave)" << endl;

	imode = 1;
	ioctlsocket(sockServer, FIONBIO, &imode);//������

	//�����λ��ֽ���
	clock_t  start = clock(); //��ʼ��ʱ

	while (recvfrom(sockServer, recBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, &len) <= 0 || !(isAck(rec) && isFin(rec) && vertifyChecksum(rec, &ph))) 
	{
		if (clock() - start >= MAX_TIME)
		{
			//��ʱ�ش�
			sendto(sockServer, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_client, len);
			cout << "Server: Sent packet (FIN), retransmission" << endl;
			start = clock();
		}
	}
	//���Ĵλ���
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

	//�����ļ��Ļ�����
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

		//д�븴���ļ�
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