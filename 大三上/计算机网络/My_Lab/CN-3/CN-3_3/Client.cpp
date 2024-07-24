#include <iostream>
#include<time.h>
#include<stdio.h>
#include<string>
#include<cstring>
#include<deque>
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
	SetCheckSum(&message, &ph);	//��У���
	// ���ع���õ���Ϣ�ṹ��
	return message;
}

int base = 1;// ���ʹ��ڵĻ���ţ���ʶ���ڵ���ʼλ�ã���һ��δȷ�ϵķ������
int lastseqnum = 1;// ��ʾ���һ���ѷ���δȷ�ϵ����
int nextseqnum;// ��ʾ��һ����Ҫ���͵���Ϣ�����кţ���С��δʹ�����
bool start_t = 0;// ��ʱ��״̬
bool rec_stage = 1;// ���ս׶�״̬
clock_t start_timer;// ��ʱ��
int packet_num;

bool* sent;        // ���ڱ���ѷ��͵�δȷ�ϵ����ݰ�
bool* timeout;     // ��ʱ��״̬�����ڱ���ѷ��͵�δȷ�ϵ����ݰ��Ƿ�ʱ

clock_t* timers;   //���ڼ�¼ÿ�����ݰ��ļ�ʱ����ȫ�ֱ����Զ���0����¼ÿ��δȷ�����ݰ��ļ�ʱ������ʱ��

// �� SR ����״̬���ⲿ���� acked ����
bool* acked;

DWORD WINAPI RecHandle(LPVOID param)
{
	// ��ȡ��ַ�ṹ��Ĵ�С
	int len = sizeof(SOCKADDR_IN);

	// �������ڴ洢��Ϣ�Ļ�����
	char* recpktBuffer = new char[sizeof(msg)];

	// ������������Ϊ��Ϣ�ṹ��
	msg* rec = (msg*)recpktBuffer;

	// ���׽�������Ϊ����ģʽ
	u_long imode = 0;
	ioctlsocket(sockClient, FIONBIO, &imode);//����

	// rec&&notcorrupt(recpkt)
	// �ڽ��ս׶�ѭ��ִ��
	while (rec_stage)
	{
		// ������Ϣ���洢�ڻ�������
		recvfrom(sockClient, recpktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, &len);

		// �����յ�����Ϣ�Ƿ���ȷ����Ϣ����δ�𻵣���ȷ�ϺŴ��ڵ���base(δ����/��ʱ)
		// ���յ�ack�󣬽���ȷ�ϵ�֡���Ϊ�ѽ���

		// �����˳��֡�����֡������Ǵ��ڵ��½磬������ǰ�ƶ���������С��ŵ�δȷ��֡��
		if (isACK(rec) && vertifyCheckSum(rec, &ph) && (rec->ack_num == base) && (rec->ack_num) < base + N)
		{
			// ���Ϊ��ȷ��
			acked[rec->ack_num] = true;

			// �رռ�ʱ��
			timeout[rec->ack_num] = false;
			
			// ������ǰ�ƶ���������С��ŵ�δȷ��֡��
			for (int i = base + 1; i <= base + N; i++)
			{
				if (i == packet_num + 1)
				{
					base += 1;
					break;
				}

				if (acked[i] == false)
				{
					base = i;
					// cout << "Windows Move !!" << endl;
					break;
				}
			}

			if (base + N + 1 <= packet_num)
			{
				printf("Receive\tack:\t%d\tchecksum:\t%d\tbase: \t%d\tnextseqnum: \t%d\tlength: \t%d\tACK: \t%d\t���ڱ߽�: \t[%d, %d]\n", rec->ack_num, rec->checksum, base, lastseqnum, rec->length, isACK(rec), base, base + N - 1);
			}
			else
			{
				printf("Receive\tack:\t%d\tchecksum:\t%d\tbase: \t%d\tnextseqnum: \t%d\tlength: \t%d\tACK: \t%d\t���ڱ߽�: \t[%d, %d]\n", rec->ack_num, rec->checksum, base, lastseqnum, rec->length, isACK(rec), packet_num - N + 1, packet_num);
			}

			if (base == lastseqnum)
			{
				start_t = 0;
			}

			else
			{
				start_t = 1;
				start_timer = clock();
			}
		}

		// ���ʹ��ڽ��յ���ack������������򴰿ڲ��ƶ�
		else if (isACK(rec) && vertifyCheckSum(rec, &ph) && (rec->ack_num > base) && (rec->ack_num) < base + N)
		{
			// ���Ϊ��ȷ��
			acked[rec->ack_num] = true;

			// �رռ�ʱ��
			timeout[rec->ack_num] = false;

			if (base + N + 1 <= packet_num)
			{
				printf("Receive\tack:\t%d\tchecksum:\t%d\tbase: \t%d\tnextseqnum: \t%d\tlength: \t%d\tACK: \t%d\t���ڱ߽�: \t[%d, %d]\n", rec->ack_num, rec->checksum, base, lastseqnum, rec->length, isACK(rec), base, base + N - 1);
			}
			else
			{
				printf("Receive\tack:\t%d\tchecksum:\t%d\tbase: \t%d\tnextseqnum: \t%d\tlength: \t%d\tACK: \t%d\t���ڱ߽�: \t[%d, %d]\n", rec->ack_num, rec->checksum, base, lastseqnum, rec->length, isACK(rec), packet_num - N + 1, packet_num);
			}

			if (base == lastseqnum)
			{
				start_t = 0;
				timeout[rec->ack_num] = false;
			}

			else
			{
				start_t = 1;
				start_timer = clock();

				// timeout[rec->ack_num] = true;
				// timers[rec->ack_num] = clock();
			}
		}

	}
	// ����ֵ1��ʾ�̺߳����������˳�
	return 1;
}

void SR_send_FSM(unsigned long length_file, char* file, char* filename, int N)
{
	// ������Ҫ���͵����ݰ�����
	packet_num = int(length_file / Max_Size) + (length_file % Max_Size ? 1 : 0);
	cout << "packet_num: " << packet_num << " " << endl;

	int index = 0;

	int len = sizeof(SOCKADDR_IN);// ��ȡ��ַ�ṹ��Ĵ�С
	int	packetDataLen = min(Max_Size, length_file - index * Max_Size);// ����ÿ�����ݰ��ĳ���
	char* dataBuffer = new char[Max_Size];// �������ڴ洢���ݵĻ�����
	char* pktBuffer = new char[sizeof(msg)];// �������ڴ洢�������ݰ��Ļ�����
	char* recpktBuffer = new char[sizeof(msg)];// �������ڴ洢����ȷ����Ϣ�Ļ�����
	msg* rec = (msg*)recpktBuffer;// �����ջ���������Ϊ��Ϣ�ṹ��
	msg sndpkt;

	acked = new bool[packet_num + 1];// ����Ƿ�ȷ��
	memset(acked, 0, packet_num + 1);

	timeout = new bool[packet_num + 1];// ��ʱ��״̬�����ڱ���ѷ��͵�δȷ�ϵ����ݰ��Ƿ�ʱ
	memset(timeout, 0, packet_num + 1);

	timers = new clock_t[packet_num + 1];// ��ʱ������¼ÿ��δȷ�����ݰ��ļ�ʱ������ʱ��
	memset(timers, 0, sizeof(clock_t) * (packet_num + 1));

	base = 1;//��ʼ�����ʹ��ڵĻ����,baseΪ�ѷ�������ȷ�ϵ����к�
	lastseqnum = 1;// lastseqnumΪ�ѷ��͵�������к�
	start_t = 0;// ��ʼ����ʱ��״̬

	// ���ڱ��ÿ�����ݰ��Ƿ��һ�η���
	bool* first_send_pkt = new bool[packet_num + 1];
	memset(first_send_pkt, 1, packet_num + 1);
	cout << "�����ļ����ݳ���Ϊ " << length_file << " Bytes, ��Ҫ���� " << packet_num << " �����ݰ�" << endl;

	// ��ʼ�����ս׶α�־
	rec_stage = 1;

	// �������ڴ���ȷ����Ϣ���յ��߳�
	HANDLE rechandler = CreateThread(nullptr, 0, RecHandle, nullptr, 0, nullptr);

	// SR����״̬����ѭ��
	while (1)
	{
		// ����Ѿ��������������ݰ�����������
		if (base >= packet_num + 1 || acked[packet_num] == true)
		{
			// �ر�ȷ����Ϣ�����߳�
			CloseHandle(rechandler);

			// �������ս׶�
			rec_stage = 0;

			// ���׽�������Ϊ������ģʽ
			u_long imode = 1;
			ioctlsocket(sockClient, FIONBIO, &imode);//������

			// �������ڴ洢���ͽ�����Ϣ�Ļ�����
			char* sendBuffer = new char[sizeof(msg)];
			memset(sendBuffer, 0, sizeof(msg));

			// �����ͽ�����Ϣ����Ϊ��Ϣ�ṹ��
			msg* sed = (msg*)sendBuffer;

			// ������Ϣ����ΪEND
			setEND(sed);

			// ����Դ�˿ں�Ŀ��˿�
			sed->source_port = port_client;
			sed->dest_port = port_server;

			// ���ļ������Ƶ���Ϣ�������ֶ�
			string fn = filename;
			int filename_len = sizeof(fn);
			memcpy(sed->msg, filename, filename_len);

			// ������Ϣ����
			sed->length = filename_len;

			//����У���
			SetCheckSum(sed, &ph);

			// ���ͽ�����Ϣ
			sendto(sockClient, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
			cout << "Client: Send packet (END)" << endl;

			clock_t start_timer = clock(); //��ʼ��ʱ

			// ѭ���ȴ����շ�������ȷ����Ϣ
			while (recvfrom(sockClient, recpktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, &len) <= 0 || !(isEND(rec) && isACK(rec)))
			{
				// ��ʱ
				if (clock() - start_timer >= MAX_TIME)
				{
					//��ʱ�ش�
					sendto(sockClient, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
					cout << "Client: Send packets (END), retransmit" << endl;
					start_timer = clock();
				}
			}

			// ���յ���ȷ�Ľ���ȷ����Ϣ���ļ��������
			if (isEND(rec) && isACK(rec) && vertifyCheckSum(rec, &ph))
			{
				cout << "Client: The server packet (END, ACK) is received, and the file transfer is completed" << endl;
				return;
			}
			else
				continue;
		}

		// ����
		// ��nextseqnumС��base+Nʱ������δ�����ſ��Է��ͱ���
		if ((lastseqnum < base + N) && (lastseqnum <= packet_num))
		{
			// ѭ������δ���͹������ݰ�
			for (int i = lastseqnum; (i < base + N) && (i <= packet_num) && first_send_pkt[i]; i++)
			{
				// �������ݰ����ļ��е����������ݰ��ĳ���
				index = i - 1;
				packetDataLen = min(Max_Size, length_file - index * Max_Size);

				// �������ݵ����ݻ�����
				memcpy(dataBuffer, file + index * Max_Size, packetDataLen);

				// �������ݰ�
				sndpkt = make_pkt(i, dataBuffer, packetDataLen);

				// �������ݰ������ͻ�����
				memcpy(pktBuffer, &sndpkt, sizeof(msg));

				// �������ݰ�
				sendto(sockClient, pktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
				nextseqnum = lastseqnum + 1;

				printf("Send\tseq: \t%d\tchecksum: \t%d\tbase: \t%d\tlastseqnum: \t%d\tnextseqnum: \t%d\tlength: \t%d\t\n", i, sndpkt.checksum, base, lastseqnum, nextseqnum, packetDataLen);

				// ��ǵ�һ���ѷ��͵���δȷ��
				first_send_pkt[i] = 0;

				// ��ʼ��ʱ��
				// ѡ���ش�SRÿ��֡����Ҫ���Լ��Ķ�ʱ��
				timeout[i] = true;
				timers[i] = clock();

				if (base == lastseqnum)
				{
					start_t = 1;
					start_timer = clock();
				}

				// �������Ϊlastseqnum��lastseqnum++
				lastseqnum++;
				nextseqnum++;
			}
		}

		// ��ʱ
		// ÿ��֡�����Լ��Ķ�ʱ����һ����ʱ�¼�������ֻ�ش�һ��֡
		if ((clock() - start_timer >= MAX_TIME) && start_t == 1)
		{
			// start_timer = clock();
			int lstseqnum = lastseqnum - 1;

			for (int i = base; i < lastseqnum; i++)
			{
				if (acked[i] == false)// �ҵ���ʱ�İ��ش�
				{
					// �������ݰ����ļ��е����������ݰ��ĳ���
					index = i - 1;
					packetDataLen = min(Max_Size, length_file - index * Max_Size);
					memcpy(dataBuffer, file + index * Max_Size, packetDataLen);
					sndpkt = make_pkt(i, dataBuffer, packetDataLen);
					memcpy(pktBuffer, &sndpkt, sizeof(msg));

					sendto(sockClient, pktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
					printf("Send\tseq: \t%d\tchecksum: \t%d\tbase: \t%d\tlastseqnum: \t%d\tnextseqnum: \t%d\tlength: \t%d\t(over time retransmit)\n", i, sndpkt.checksum, base, lstseqnum, lastseqnum, packetDataLen);
					
					// ���������ش����ݰ��Ķ�ʱ��
					start_timer = clock();
					timers[i] = clock();

					break;
				}
			}
		}
	}
}
/*
// �����жϷ����Ƿ���ȷ��
bool isACKed(int seq_num)
{
	return acked[seq_num%N];
}

// ���ڽ�������Ϊ��ȷ��
void markAsACKed(int seq_num)
{
	acked[seq_num%N] = true;
}
DWORD WINAPI RecHandle(LPVOID param)
{
	// ��ȡ��ַ�ṹ��Ĵ�С
	int len = sizeof(SOCKADDR_IN);

	// �������ڴ洢��Ϣ�Ļ�����
	char* recpktBuffer = new char[sizeof(msg)];

	// ������������Ϊ��Ϣ�ṹ��
	msg* rec = (msg*)recpktBuffer;

	// ���׽�������Ϊ����ģʽ
	u_long imode = 0;
	ioctlsocket(sockClient, FIONBIO, &imode);//����

	// rec&&notcorrupt(recpkt)
	// �ڽ��ս׶�ѭ��ִ��
	while (rec_stage)
	{
		// ������Ϣ���洢�ڻ�������
		recvfrom(sockClient, recpktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, &len);
		
		// �����յ�����Ϣ�Ƿ���ȷ����Ϣ����δ�𻵣���ȷ�Ϻ�=base�����½�
		// ���յ�ack�󣬽���ȷ�ϵ�֡���Ϊ�ѽ���
		// �����˳��֡�����֡������Ǵ��ڵ��½磬������ǰ�ƶ���������С��ŵ�δȷ��֡��
		// ��������ƶ��˲���������ڴ����ڵ�δ����֡��������Щ֡
		if (rec->ack_num == base && isACK(rec) && vertifyCheckSum(rec, &ph))
		{
			// �����������յ�ȷ��
			markAsACKed(rec->ack_num);

			if (base + N + 1 <= packet_num)
			{
				printf("Receive\tACK:\t%d\tack:\t%d\tchecksum:\t%d\t\n", isACK(rec), rec->ack_num, rec->checksum);
			}
			else
			{
				printf("Receive\tACK:\t%d\tack:\t%d\tchecksum:\t%d\n", isACK(rec), rec->ack_num, rec->checksum);
			}

			// ������ǰ�ƶ���������С��ŵ�δȷ��֡��
			for (int i = base + 1; i <= base + N; i++)
			{
				if (acked[i] == false)
				{
					base = i;
					cout << "�����Ƶ� base = " << i << "��" << endl;
					break;
				}
			}

			// �����ֹͣ��ʱ����ʾ�ѽ���
			// start_t = 1;
			timeout[rec->ack_num] = false;
			timers[rec->seq_num] = 0;

		}
		// �����յ�����Ϣ�Ƿ���ȷ����Ϣ����δ�𻵣���ȷ�Ϻ��ڴ��ڷ�Χ�ڣ����������������յ���
		else if (isACK(rec) && vertifyCheckSum(rec, &ph) && (rec->ack_num > base) && (rec->ack_num < base + N))
		{
			// �����������յ�ȷ��
			markAsACKed(rec->ack_num);

			// �����Ӧ��ֹͣ��ʱ����ʾ�Ѿ�����
			// start_t = 1;
			timeout[rec->ack_num] = false;
			timers[rec->ack_num] = 0;
		
			// ���ʹ��ڽ��յ���ack������������򴰿ڲ��ƶ�

			printf("Receive\tACK:\t%d\tack:\t%d\tchecksum:\t%d\t\n", isACK(rec), rec->ack_num, rec->checksum);
			cout << "������գ����ڲ��ƶ�" << endl;
		}

		else if (isACK(rec) && vertifyCheckSum(rec, &ph) && (rec->ack_num < base))
		{
			// �����������յ�ȷ��
			markAsACKed(rec->ack_num);
		}
	}
	// ����ֵ1��ʾ�̺߳����������˳�
	return 1;
}

void SR_send_FSM(unsigned long length_file, char* file, char* filename, int N)
{
	// ������Ҫ���͵����ݰ�����
	packet_num = int(length_file / Max_Size) + (length_file % Max_Size ? 1 : 0);
	cout << "packet_num: " << packet_num << " " << endl;

	int index = 0;

	int len = sizeof(SOCKADDR_IN);// ��ȡ��ַ�ṹ��Ĵ�С
	int	packetDataLen = min(Max_Size, length_file - index * Max_Size);// ����ÿ�����ݰ��ĳ���
	char* dataBuffer = new char[Max_Size];// �������ڴ洢���ݵĻ�����
	char* pktBuffer = new char[sizeof(msg)];// �������ڴ洢�������ݰ��Ļ�����
	char* recpktBuffer = new char[sizeof(msg)];// �������ڴ洢����ȷ����Ϣ�Ļ�����
	msg* rec = (msg*)recpktBuffer;// �����ջ���������Ϊ��Ϣ�ṹ��
	msg sndpkt;

	timeout = new bool[packet_num + 1];// ��ʱ��״̬�����ڱ���ѷ��͵�δȷ�ϵ����ݰ��Ƿ�ʱ
	memset(timeout, 0, packet_num + 1);

	timers = new clock_t[packet_num + 1];// ��ʱ������¼ÿ��δȷ�����ݰ��ļ�ʱ������ʱ��
	memset(timers, 0, sizeof(clock_t) * (packet_num + 1));

	base = 1;//��ʼ�����ʹ��ڵĻ����,baseΪ�ѷ�������ȷ�ϵ����к�
	lastseqnum = 1;// lastseqnumΪ�ѷ��͵�������к�
	start_t = 0;// ��ʼ����ʱ��״̬

	// ���ڱ��ÿ�����ݰ��Ƿ��һ�η���
	bool* first_send_pkt = new bool[packet_num + 1];
	memset(first_send_pkt, 1, packet_num + 1);
	cout << "�����ļ����ݳ���Ϊ " << length_file << " Bytes, ��Ҫ���� " << packet_num << " �����ݰ�" << endl;

	// ��ʼ�����ս׶α�־
	rec_stage = 1;

	// ��ʼ�� acked����Ǵ����ڵķ���Ϊδȷ��״̬
	acked.assign(N, false);

	// �������ڴ���ȷ����Ϣ���յ��߳�
	HANDLE rechandler = CreateThread(nullptr, 0, RecHandle, nullptr, 0, nullptr);

	// SR����״̬����ѭ��
	while (1)
	{
		// ����Ѿ��������������ݰ�����������
		if (base == packet_num + 1)
		{
			// �ر�ȷ����Ϣ�����߳�
			CloseHandle(rechandler);

			// �������ս׶�
			rec_stage = 0;

			// ���׽�������Ϊ������ģʽ
			u_long imode = 1;
			ioctlsocket(sockClient, FIONBIO, &imode);//������

			// �������ڴ洢���ͽ�����Ϣ�Ļ�����
			char* sendBuffer = new char[sizeof(msg)];
			memset(sendBuffer, 0, sizeof(msg));

			// �����ͽ�����Ϣ����Ϊ��Ϣ�ṹ��
			msg* sed = (msg*)sendBuffer;

			// ������Ϣ����ΪEND
			setEND(sed);

			// ����Դ�˿ں�Ŀ��˿�
			sed->source_port = port_client;
			sed->dest_port = port_server;

			// ���ļ������Ƶ���Ϣ�������ֶ�
			string fn = filename;
			int filename_len = sizeof(fn);
			memcpy(sed->msg, filename, filename_len);

			// ������Ϣ����
			sed->length = filename_len;

			//����У���
			SetCheckSum(sed, &ph);

			// ���ͽ�����Ϣ
			sendto(sockClient, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
			cout << "Client: Send packet (END)" << endl;

			clock_t start_timer = clock(); //��ʼ��ʱ

			// ѭ���ȴ����շ�������ȷ����Ϣ
			while (recvfrom(sockClient, recpktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, &len) <= 0 || !(isEND(rec) && isACK(rec)))
			{
				// ��ʱ
				if (clock() - start_timer >= MAX_TIME)
				{
					//��ʱ�ش�
					sendto(sockClient, sendBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
					cout << "Client: Send packets (END), retransmit" << endl;
					start_timer = clock();
				}
			}

			// ���յ���ȷ�Ľ���ȷ����Ϣ���ļ��������
			if (isEND(rec) && isACK(rec) && vertifyCheckSum(rec, &ph))
			{
				cout << "Client: The server packet (END, ACK) is received, and the file transfer is completed" << endl;
				return;
			}
			else
				continue;
		}

		// ����
        // ��nextseqnumС��base+Nʱ������δ�����ſ��Է��ͱ���
		// �������ڵ�������������
		if ((lastseqnum < base + N) && (lastseqnum <= packet_num))
		{
			// ѭ������δ���͹������ݰ�
			for (int i = lastseqnum; (i < base + N) && (i <= packet_num) && first_send_pkt[i]; i++)
			{
				// �������ݰ����ļ��е����������ݰ��ĳ���
				index = i - 1;
				packetDataLen = min(Max_Size, length_file - index * Max_Size);

				// �������ݵ����ݻ�����
				memcpy(dataBuffer, file + index * Max_Size, packetDataLen);

				// �������ݰ�
				sndpkt = make_pkt(i, dataBuffer, packetDataLen);

				// �������ݰ������ͻ�����
				memcpy(pktBuffer, &sndpkt, sizeof(msg));

				// �������ݰ�
				sendto(sockClient, pktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
				nextseqnum = lastseqnum + 1;

				printf("Send\tseq: \t%d\tchecksum: \t%d\tbase: \t%d\tlastseqnum: \t%d\tnextseqnum: \t%d\tlength: \t%d\t\n", i, sndpkt.checksum, base, lastseqnum, nextseqnum, packetDataLen);

				// ��ǵ�һ���ѷ��͵���δȷ�ϵ�֡
				first_send_pkt[i] = false;

				// ѡ���ش�Ӧ��ÿ��֡�����Լ��Ķ�ʱ��				
				// ������ʱ��
			    // start_t = 1;
				timeout[i] = true;
				timers[i] = clock();

				// �������Ϊlastseqnum��lastseqnum++
				lastseqnum++;
				nextseqnum++;
			}
		}

		// ��ʱ�ش�
		// ÿ��֡�����Լ��Ķ�ʱ����һ����ʱ�¼�������ֻ�ش�һ��֡
		if (start_t && (clock() - timers[base]) >=	MAX_TIME)
		{
			int lstseqnum = lastseqnum - 1;
			// �ش���base��lastseqnumδȷ�ϵ����ݰ�
			for (int i = base; i <lastseqnum; i++)
			{
				// ���������Ƿ��Ѿ�ȷ��
				if (!isACKed(i))
				{
					// �������ݰ����ļ��е����������ݰ��ĳ���
					index = i - 1;
					packetDataLen = min(Max_Size, length_file - index * Max_Size);
					memcpy(dataBuffer, file + index * Max_Size, packetDataLen);
					sndpkt = make_pkt(i, dataBuffer, packetDataLen);
					memcpy(pktBuffer, &sndpkt, sizeof(msg));

					sendto(sockClient, pktBuffer, sizeof(msg), 0, (sockaddr*)&addr_server, len);
					printf("Send\tseq: \t%d\tchecksum: \t%d\tbase: \t%d\tlastseqnum: \t%d\tnextseqnum: \t%d\tlength: \t%d\t(over time retransmit)\n", i, sndpkt.checksum, base, lstseqnum, lastseqnum, packetDataLen);

					// ���������ش����ݰ��Ķ�ʱ��
					timers[i] = clock();// �ҵ���һ����ʱ�İ�
					break;
				}
			}
		}
	}

}*/

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
	cout << endl;

	// int N;
	cout << "Windows�� ";
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

		SR_send_FSM(fileLen, fileBuffer, filename, N);

		clock_t end_timer = clock();
		double endtime = (double)(end_timer - start_timer) / CLOCKS_PER_SEC;
		cout << "Total time: " << endtime << " s" << endl;
		cout << "Throughput: " << fileLen * 8 / endtime / 1024 / 1024 << "Mbps" << endl;
	}
	closeConnect();
	WSACleanup();
	return 0;
}
