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

typedef unsigned char BYTE; // 1�ֽ�
typedef unsigned short WORD; // 2�ֽ�
typedef unsigned long DWORD; // 4�ֽ�

#define Max_Size 8192
#define MAX_TIME 100

// ������Ϣ�ṹ�壬����
typedef struct Message
{
	WORD source_port = 0, dest_port = 0;	//2�ֽ�Դ�˿ں�2�ֽ�Ŀ��˿�
	DWORD seq_num = 0, ack_num = 0;			//4�ֽ����кź�4�ֽ�ȷ�Ϻ�
	WORD  length = 0;					//2�ֽڳ���
	BYTE  flag = 0;				     //1�ֽڱ�־λ
	WORD checksum = 0;					//2�ֽ�У���
	char msg[Max_Size] = { 0 };// ��Ϣ����
}msg;

// ����UDPα�ײ��ṹ��
typedef struct UDP_PseudoHead
{
	DWORD source_ip = 0, dest_ip = 0;		//ԴIP��Ŀ��IP
	char zero = 0;// Ԥ���ֶΣ����0
	char protocol = 0;// Э���ֶ�
	WORD length = sizeof(msg);// �����ֶ�
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
// �����־λ
void cleanflag(msg* msg) 
{
	msg->flag |= 0x0;
}
// �ж��Ƿ���ACK
bool isACK(msg* msg)
{
	return msg->flag & 0x01;
}
// �ж��Ƿ���SYN
bool isSYN(msg* msg)
{
	return msg->flag & 0x02;
}
// �ж��Ƿ���FIN
bool isFIN(msg* msg)
{
	return msg->flag & 0x04;
}
// �ж��Ƿ���END
bool isEND(msg* msg)
{
	return msg->flag & 0x08;
}

// ����ACK��־λ
void setACK(msg* msg) 
{
	msg->flag |= 0x01;
}
// ����SYN��־λ
void setSYN(msg* msg)
{
	msg->flag |= 0x02;
}
// ����FIN��־λ
void setFIN(msg* msg)
{
	msg->flag |= 0x04;
}
// ����END��־λ
void setEND(msg* msg) 
{
	msg->flag |= 0x08;
}
// ������Ϣ����
void setMsg(msg* msg, char* data)
{
	memcpy(msg->msg, data, Max_Size);
};

//rdt2.0���ǲ����ص�����������˲���⡢���ն˷�����NAK/ACK����/�϶�ȷ�ϣ������Ͷ��ش�
// ���޷�����ACK/NAK������������������Ͷ�ֻ���ش���ǰ���ݷ��飬�ᵼ���������
// ���շ�Ҳ��֪�����ϴη��͵�ACK/NAK�Ƿ���ȷ����
// rdt2.1�з��Ͷ���ÿ���������������кţ����ҽ��ն˶����ظ��ķ���
// rdt2.2����NAK��ֻʹ��ACK
// rdt3.0���Ƕ����Ͳ�����

// ������Ϣʱ����У���
void SetCheckSum(msg* message, psh* ph) 
{
	//��Ϣ��У�������Ϊ0
	message->checksum = 0;
	int sum = 0;
	int len_pseudo = sizeof(psh);
	int len_msg = sizeof(msg);

	// ����α�ײ���У��ͣ���α�ײ���ÿ�����ֽ���Ϊ16λ���������
	for (int i = 0; i < len_pseudo / 2; i++) 
	{
		sum += ((WORD*)ph)[i];
	}
	// ������Ϣ��У��ͣ�����Ϣ��ÿ�����ֽ���Ϊ16λ���������
	for (int i = 0; i < len_msg / 2; i++) 
	{
		sum += ((WORD*)message)[i];
	}
	// �����λ������н�λ���ͽ���λ���ּӻص�sum�ĵ�16λ�С�
	while (sum >> 16) 
	{
		sum = (sum & 0xFFFF) + (sum >> 16);
	}
	// ��У���ȡ������ֵ����Ϣ��У����ֶ�
	message->checksum = ~sum;
};

// ������Ϣʱ��֤У���
bool vertifyCheckSum(msg* message, psh* ph)
{
	int sum = 0;
	int len_pseudo = sizeof(psh);
	int len_msg = sizeof(msg);

	// ����α�ײ���У���
	for (int i = 0; i < len_pseudo / 2; i++) 
	{
		sum += ((WORD*)ph)[i];
	}

	// ������Ϣ��У��ͣ�����н�λ���ͽ���λ���ּӻص�sum�ĵ�16λ�С�
	for (int i = 0; i < len_msg / 2; i++) 
	{
		sum += ((WORD*)message)[i];
	}

	// �����λ
	while (sum >> 16) 
	{
		sum = (sum & 0xFFFF) + (sum >> 16);
	}

	// ��֤У����Ƿ�Ϊ0xFFFF
	return sum == 0xFFFF;
};

SOCKET sockClient; // ����ͻ����׽���
SOCKADDR_IN addr_client; // ����ͻ��˵�ַ�ṹ��
SOCKADDR_IN addr_server; // �����������ַ�ṹ��

char  ip_client[] = "127.0.0.1"; // ����ͻ���IP
WORD  port_client = 7777; // ����ͻ��˶˿�
char ip_server[] = "127.0.0.1"; // ���������IP
WORD  port_server = 8888; // ����������˿�

char ip_route[] = "127.0.0.1"; // ����·����IP
WORD  port_route = 9999; // ����·�����˿�

psh ph;		//α�ײ�

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

	// ���ÿͻ��˵�ַ�ṹ
	addr_client.sin_port = htons(port_client);					//port
	addr_client.sin_addr.S_un.S_addr = inet_addr(ip_client); //ip addr
	addr_client.sin_family = AF_INET;
	// ���÷�������ַ�ṹ
	addr_server.sin_port = htons(port_route);
	addr_server.sin_addr.S_un.S_addr = inet_addr(ip_route);
	addr_server.sin_family = AF_INET;
	// �����׽���
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

	// �����׽���Ϊ������ģʽ
	u_long imode = 1;
	ioctlsocket(sockClient, FIONBIO, &imode);//������

	// ���׽��ְ󶨵��ͻ��˵�ַ
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

	//��ʼ��αͷ��
	memset(&ph, 0, sizeof(psh));
	ph.source_ip = inet_addr(ip_client);
	ph.dest_ip = inet_addr(ip_server);

	//��ʼ����ɣ��ͻ�������
	cout << "Initialization successful. Client is now connecting..." << endl;
};

bool establishConnect() 
{
	int len = sizeof(SOCKADDR_IN);
	char recBuffer[sizeof(msg)];	//���ջ�����
	char sendBuffer[sizeof(msg)];	//���ͻ�����

	//��ʼ��recBuffer��sendBuffer���������������ڴ洢���պͷ��͵���Ϣ
	memset(recBuffer, 0, sizeof(msg));
	memset(sendBuffer, 0, sizeof(msg));

	//����ָ���ͺͽ�����Ϣ��ָ��sed��rec
	msg* sed = (msg*)sendBuffer;
	msg* rec = (msg*)recBuffer;

	// ��һ�����֣�Client����SYN�����λΪSYN=1,seq=0,ack=0
	setSYN(sed);		//����SYN
	sed->seq_num = 0;	//����seq=0
	sed->ack_num = 0;	//����ack=0
	sed->source_port = port_client;//Դ�˿�
	sed->dest_port = port_server;//Ŀ�Ķ˿�
	SetCheckSum(sed, &ph);	//����У���

	//��SYN���ݰ����͵�������
	sendto(sockClient, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
	cout << "Client: Sent SYN (First Handshake)" << endl;

	//������ʱ����start���Դ���Ǳ�ڵĳ�ʱ���
	clock_t start = clock(); 

	// �ڶ������֣�Client����SYN, ACK
	while (recvfrom(sockClient, recBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, &len) <= 0) 
	{
		//�����ָ����ʱ���ڣ�MAX_TIME��δ�յ���Ӧ�������´���SYN���ݰ�
		if (clock() - start >= MAX_TIME) 
		{
			//��ʱ�ش�
			sendto(sockClient, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
			start = clock();
		}
	}
	//cout << "Client: Received SYN, ACK (Second Handshake)" << endl;

	//�����յ������ݰ��Ƿ�����Ч��SYN-ACK���ݰ�
	if (isACK(rec) && isSYN(rec) && vertifyCheckSum(rec, &ph)) 
	{
		//���ճɹ�
		cout << "Client: Received packet (SYN, ACK) validation successful!(Second Shake)" << endl;
		//���������֣�ACK=1��seq=1��ack=1
		//������ݰ���Ч����׼��һ��ACK���ݰ���������ȷ�Ϸ�����
		memset(sendBuffer, 0, sizeof(msg));
		setACK(sed);	//����ack
		sed->seq_num = 1;
		sed->ack_num = 1;
		sed->source_port = port_client;
		sed->dest_port = port_server;

		SetCheckSum(sed, &ph);
		// ���������֣�Client����ACK
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

// Դ����Ӧ�ó���ı��ķ������ɱ��Ķ�
msg make_pkt(int seq, char* data, unsigned short len) 
{
	msg message;// ����һ����Ϣ�ṹ��
	memset(&message, 0, sizeof(msg));// ��ʼ����Ϣ�ṹ�壬��������ȫ������Ϊ0
	message.source_port = port_client;// ������Ϣ��Դ�˿�
	message.dest_port = port_server;// ������Ϣ��Ŀ��˿�
	message.length = len;// ������Ϣ�ĳ���
	message.seq_num = seq;// ������Ϣ�����к�
	memcpy(message.msg, data, len);// �������ݵ���Ϣ�������ֶ�

	psh ph;		// ����һ��α�ײ��ṹ��
	memset(&ph, 0, sizeof(psh));// ��ʼ��α�ײ��ṹ�壬��������ȫ������Ϊ0
	ph.source_ip = inet_addr(ip_client);// ����α�ײ���ԴIP��ַ
	ph.dest_ip = inet_addr(ip_server);// ����α�ײ���Ŀ��IP��ַ
	SetCheckSum(&message, &ph);	//����У���

	return message;// ���ع���õ���Ϣ�ṹ��
}
// ·�ɣ��������˷����İ����򲻽��д���ֱ��ת�����ͻ���
// �������ݵ�״̬������
void rdt3_send_FSM(unsigned long length_file, char* file, char* filename) 
{
	// �����ܹ���Ҫ���͵����ݰ�����
	int packetNUM = int(length_file / Max_Size) + (length_file % Max_Size ? 1 : 0);
	cout << "packetNUM: " << packetNUM << endl;
	cout << endl;

	int count = 0;// ��ǰ���ݰ�����
	int state = 0;// ��ǰ״̬
	int len = sizeof(SOCKADDR_IN);// ��ַ�ṹ�峤��
	int	packetDataLen = min(Max_Size, length_file - count * Max_Size);// ��ǰ���ݰ��е����ݳ���
	char* dataBuffer = new char[Max_Size];// ���ݻ�����
	char* pktBuffer = new char[sizeof(msg)];// ���ݰ�������
	char* recpktBuffer = new char[sizeof(msg)];// �������ݰ�������
	msg sndpkt;// ���͵����ݰ�
	clock_t start_timer;// ��ʱ��

	msg* rec = (msg*)recpktBuffer;// ���յ������ݰ�

	cout << "���ļ����ݳ���Ϊ " << length_file << "Bytes, ��Ҫ����" << packetNUM << "�����ݰ�" << endl;

	while (1) 
	{
		//���ʹ����������
		if (count == packetNUM)
		{
			// ����Ϊ������ģʽ
			u_long imode = 1;
			ioctlsocket(sockClient, FIONBIO, &imode);

			char* sendBuffer = new char[sizeof(msg)];
			memset(sendBuffer, 0, sizeof(msg));
			msg* sed = (msg*)sendBuffer;

			// ���ô��������־
			setEND(sed);
			sed->source_port = port_client;// ����Դ�˿�
			sed->dest_port = port_server;// ����Ŀ��˿�
			string fn = filename;
			int filename_len = sizeof(fn);

			memcpy(sed->msg, filename, filename_len);// �����ļ�������Ϣ�����ֶ�
			sed->length = filename_len;// ������Ϣ����
			SetCheckSum(sed, &ph);	//����У���

			// ���ʹ����������
			sendto(sockClient, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
			cout << "Client: Sent packet (END)" << endl;

			clock_t start_timer = clock(); //��ʼ��ʱ
			// �ȴ����շ�������ȷ��
			while (recvfrom(sockClient, recpktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, &len) <= 0 || !(isEND(rec) && isACK(rec))) 
			{
				// ��ʱ�ش�
				if (clock() - start_timer >= MAX_TIME)
				{
					// ��ʱ�ش������������
					sendto(sockClient, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
					cout << "Client: Sent packet (END), Retransmitting..." << endl;
					start_timer = clock();
				}
			}
			// ���յ���������ȷ�ϣ��ļ��������
			if (isEND(rec) && isACK(rec) && vertifyCheckSum(rec, &ph))
			{
				cout << "Client: Received server packet (END, ACK), File transfer completed." << endl;
				return;
			}
			else
				continue;
		}
		// ���㵱ǰ���ݰ������ݳ���
		packetDataLen = min(Max_Size, length_file - count * Max_Size);

		switch (state)
		{
		/*
		�����״̬�£����ݱ����Ƶ����������������ݰ����������к�Ϊ2�����������ݰ�
		״̬0��ʾ���ͷ�׼������һ�����к�Ϊ2�����ݰ�
		*/
		case 0:
			// �������ݵ����������������ݰ����������к�Ϊ2
			memcpy(dataBuffer, file + count * Max_Size, packetDataLen);

			//rdt3.0��Դ����Ӧ�ó���ı��ķ������ɱ��ĶΣ��������к�Ϊ2
			sndpkt = make_pkt(2, dataBuffer, packetDataLen);
			//rdt3.0���洢��������
			memcpy(pktBuffer, &sndpkt, sizeof(msg));

			// rdt3.0: �������ݰ����������ɵı��Ķ��������ŵ�
			sendto(sockClient, pktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
			//rdt3.0: ������ɺ����ö�ʱ���¼�
			start_timer = clock();// ��ʼ��ʱ
			state = 1;// rdt3.0: ������һ״̬��Ϊ�ȴ����Ϊ2���Ķε�ackӦ��״̬
			cout << "Case 0: State 0-Sent         " << std::setw(20) << std::left << "seq: 2" << "count : " << std::setw(20) << std::left << count << "length : " << std::setw(20) << std::left << packetDataLen << " checksum : " << std::setw(20) << std::left << sndpkt.checksum << endl;
			break;

		/*
		�ȴ��������Է�������ȷ�ϣ�������յ���ȷ��ȷ�ϣ�ACK=2���������״̬2�����򣬸��ݳ�ʱ�����ش�
		״̬1��ʾ���ͷ��ѷ������ݰ����ȴ����Է�������ȷ�ϡ�
		*/
		case 1:
			//rdt3.0: ��ʱ�ش������Ͷ��ڹ涨�ĳ�ʱʱ����û���յ���������ȷ����Ϣ�����Ͷ˻ᴥ����ʱ�ش����ơ�
			//��ʱ�ش������·���֮ǰ���͵����ݰ�����ȷ�����ݵĿɿ����䡣
			if (clock() - start_timer >= MAX_TIME) 
			{
				// ��ʱ�ش����ݰ�
				sendto(sockClient, pktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
				cout << "Case 1: State 0-Sent         " << std::setw(20) << std::left << "seq: 2" << "count : " << std::setw(20) << std::left << count << "length : " << std::setw(20) << std::left << packetDataLen << " checksum : " << std::setw(20) << std::left << sndpkt.checksum << std::setw(20) << std::left << " (Retransmitted)" << std::setw(20) << std::left << endl;
				//rdt3.0: ������ɺ����ö�ʱ���¼�
				start_timer = clock();
			}

			// ���շ�������ȷ��
			// rdt3.0: ������յ���ȷ����Ϣ��ACK������ȷ����У�����֤ʧ�ܣ����Ͷ˻���Ը�ȷ����Ϣ�����ȴ��ش���
			// rdt3.0: ��ʱ�ش������·���֮ǰ���͵����ݰ�����ȷ�����ݵ���ȷ���䡣
			if (recvfrom(sockClient, recpktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, &len)) 
			{
				if (isACK(rec) && vertifyCheckSum(rec, &ph) && rec->ack_num == 2) 
				{
					cout << "Case 1: State 1-Received     " << std::setw(20) << std::left << "ack: 2" << "Ack : " << std::setw(20) << std::left << isACK(rec)<< "  length : " << std::setw(20) << std::left << rec->length  << " checksum : " << std::setw(20) << std::left << rec->checksum << endl;
					state = 2;// rdt3.0: ������һ״̬,���������µ����к�Ϊ3�����ݰ�
					count++;// �������ݰ�����
					break;
				}
			}
			break;

		/*
		�����״̬�£����ݱ����Ƶ����������������ݰ����������к�Ϊ3�����������ݰ���
		״̬2��ʾ���ͷ�׼������һ�����к�Ϊ3�����ݰ���
		*/
		case 2:
			// �������ݵ����������������ݰ����������к�Ϊ3
			memcpy(dataBuffer, file + count * Max_Size, packetDataLen);
			//rdt3.0��Դ����Ӧ�ó���ı��ķ������ɱ��ĶΣ��������к�Ϊ3
			sndpkt = make_pkt(3, dataBuffer, packetDataLen);
			//rdt3.0���洢��������
			memcpy(pktBuffer, &sndpkt, sizeof(msg));

			// rdt3.0: �������ݰ����������ɵı��Ķ��������ŵ�
			sendto(sockClient, pktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
			cout << "Case 2: State 2-Sent         " << std::setw(20) << std::left << "seq: 3" << "count : " << std::setw(20) << std::left << count << "length : " << std::setw(20) << std::left << packetDataLen << " checksum : " << std::setw(20) << std::left << sndpkt.checksum << endl;

			//rdt3.0: ������ɺ����ö�ʱ���¼�
			start_timer = clock();// ��ʼ��ʱ
			state = 3;// rdt3.0:  ������һ״̬��Ϊ�ȴ����Ϊ3���Ķε�ackӦ��״̬
			break;

		/*
		�ȴ��������Է�������ȷ�ϣ�������յ���ȷ��ȷ�ϣ�ACK=3���������״̬0�����򣬸��ݳ�ʱ�����ش���
		״̬3��ʾ���ͷ��ѷ������ݰ����ȴ����Է�������ȷ�ϡ�
		*/
		case 3:
			//rdt 3.0: ��ʱ�ش�.������Ͷ��ڹ涨�ĳ�ʱʱ����û���յ���������ȷ����Ϣ��
			//���Ͷ˻ᴥ����ʱ�ش�����
			if (clock() - start_timer >= MAX_TIME)
			{
				// ��ʱ�ش����ݰ�
				sendto(sockClient, pktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
				cout << "Case 3: State 2-Sent         " << std::setw(20) << std::left << "seq: 3" << "count : " << std::setw(20) << std::left << count << "length : " << std::setw(20) << std::left << packetDataLen << " checksum : " << std::setw(20) << std::left << sndpkt.checksum << std::setw(20) << std::left << "(Retransmitted)" << endl;
				//rdt3.0: ������ɺ����ö�ʱ���¼�
				start_timer = clock();
			}
			// ���շ�������ȷ��
			// rdt3.0: ������յ���ȷ����Ϣ��ACK������ȷ����У�����֤ʧ�ܣ�
			//���Ͷ˻���Ը�ȷ����Ϣ�����ȴ���ʱ�ش�s
			if (recvfrom(sockClient, recpktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, &len)) 
			{
				if (isACK(rec) && vertifyCheckSum(rec, &ph) && rec->ack_num == 3) 
				{
					cout << "Case 3: State 3-Received     " << std::setw(20) << std::left << "ack: 3" << "Ack : " << std::setw(20) << std::left << isACK(rec) << "  length : " << std::setw(20) << std::left << rec->length << " checksum : " << std::setw(20) << std::left << rec->checksum << endl;
					cout << endl;
					state = 0;// ������һ״̬
					count++;// �������ݰ�����
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
	char recBuffer[sizeof(msg)];	//���ջ�����
	char sendBuffer[sizeof(msg)];	//���ͻ�����

	memset(recBuffer, 0, sizeof(msg));
	memset(sendBuffer, 0, sizeof(msg));

	msg* sed = (msg*)sendBuffer;
	msg* rec = (msg*)recBuffer;

	//��һ�λ��֣��ͻ��˷���FIN���ģ�FIN=1,seq=0,ack=0
	setFIN(sed);		//����Fin
	sed->seq_num = 0;	//����seq=0
	sed->ack_num = 0;	//����ack=0
	sed->source_port = port_client;
	sed->dest_port = port_server;
	SetCheckSum(sed, &ph);	//����У���

	//����
	sendto(sockClient, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
	cout << "Client: Sent packet (FIN) (First wave)" << endl;

	clock_t start = clock(); //��ʼ��ʱ

	//�ڶ��λ��֣�����ȷ���������˵�FIN��ACK����
	while (recvfrom(sockClient, recBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, &len) <= 0)
	{
		// over time
		if (clock() - start >= MAX_TIME) 
		{
			//��ʱ�ش�
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
	ioctlsocket(sockClient, FIONBIO, &imode);//����

	//�����λ��֣�����ȷ���������˵�FIN����

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
	ioctlsocket(sockClient, FIONBIO, &imode);//������

	//���Ĵλ��֣�����FIN��ACK���ģ�FIN=1,ACK=1
	cleanflag(sed);
	setFIN(sed);
	setACK(sed);
	SetCheckSum(sed, &ph);	//����У���
	sendto(sockClient, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
	cout << "Client: Sent packet (FIN, ACK) (Fourth wave)" << endl;

	//�ȴ�2MSL
	start = clock(); //��ʼ��ʱ

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
	//��ʼ��
	ClientInit();
	//��������
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
		cout << "�ļ��������:  " << endl;
		cout << "1: 1.jpg" << endl;
		cout << "2: 2.jpg" << endl;
		cout << "3: 3.jpg" << endl;
		cout << "4: helloworld.txt" << endl;
		cout << "5: a.jpg" << endl;
		cout << "6: Exit" << endl;
		cout << "������Ҫ������ļ��� " << endl;

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