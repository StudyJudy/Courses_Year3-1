#include <iostream>
#include <vector>
#include <string>
#include <thread>
#include <cstring>
#include <cstdlib>
#include <mutex>
#include <WinSock2.h>
#include <ws2tcpip.h>
#include <ctime>
#include "commoncode.h"

#pragma comment(lib, "ws2_32.lib")

using namespace std;

typedef struct CLIENT
{
	SOCKET client_Socket;//�ͻ����׽���  
	char clientname[20];//�ͻ���
	char time_stamp[64];//��ǰʱ����ַ���
	char content_buf[256];//�ͻ����յ���Ϣ�����������ʾ�����͵��ַ���
	int flag;//��ǰ�ͻ��˱��
}CLIENT;

//vector<int> clientSockets;// �洢���ӵĿͻ����׽���
CLIENT clients[20];//���������20��
//mutex mtx; // �����������ڱ��� clientSockets ������ȷ�����̷߳���ʱ��ͬ����
//vector<CLIENT> clients;

int num = 0;//��ǰ�ͻ��˵ı��

// �������ͻ��˵��߳�
DWORD WINAPI handleClient(LPVOID lpParam)
{
	CLIENT* Client = (CLIENT*)lpParam; // ��������ʼ��һ�� CLIENT ָ��
	char timestamp[64] = {};  // ʱ������������ַ�����ʱ���ʽ
	char content[256];   // ���յ�������Ϣ����
	int i = 0;
	char tmp1[] = "[ ";
	char tmp2[] = " ]";
	char tmp3[] = " Received message from client: ";
	char tmp4[] = " message: ";
	char tmp5[] = "Server: ";
	
	while (true)
	{
		memset(content, 0, sizeof(content));
		//memset(timestamp, 0, sizeof(timestamp));

		//��������
		int recv_time = recv(Client->client_Socket, timestamp, sizeof(timestamp), 0);
		int recv_con = recv(Client->client_Socket, content, sizeof(content), 0);
		//int recv_time = receiveMessage(Client->client, timestamp);
		//int ret_con = receiveMessage(Client->client, content);
		
		//ƴ�ӷ��������յ���Ϣ����ʾ��ʽ
		if (recv_con > 0)
		{
			strcpy_s(Client->content_buf, sizeof(Client->content_buf), tmp5);
			strcat_s(Client->content_buf, sizeof(Client->content_buf), tmp1);
			strcat_s(Client->content_buf, sizeof(Client->content_buf), timestamp);
			strcat_s(Client->content_buf, sizeof(Client->content_buf), tmp2);
			strcat_s(Client->content_buf, sizeof(Client->content_buf), tmp3);
			strcat_s(Client->content_buf, sizeof(Client->content_buf), Client->clientname);
			strcat_s(Client->content_buf, sizeof(Client->content_buf), tmp4);
			strcat_s(Client->content_buf, sizeof(Client->content_buf), content);
			//�������˵���ʾ
			cout << Client->content_buf << endl;

			//lock_guard<mutex> lock(mutex);//ʹ�û�������ȷ������̰߳�ȫ�ز��� clients vector,����������Դ clients

			if (strcmp(content, "exit_request") != 0)
			{
				for (i = 0; i < num; i++)
				{
					if (i != Client->flag)
					{
						// ���ͻظ���Ϣ���ͻ��� 
						SOCKET send_result = send(clients[i].client_Socket, Client->content_buf, strlen(Client->content_buf), 0);
						//sendMessage(Client->client, Client->buf);
						if (send_result == SOCKET_ERROR)// �����ʹ���
						{
							//cerr << "1Server: Failed to send message to client " << Client->clientname <<  ". Error: " << WSAGetLastError() << endl;

						}
					}

				}
			}
			else
			{
				for (i = 0; i < num; i++)
				{
					if (i == Client->flag)
					{
						SOCKET send_result = send(clients[i].client_Socket, content, strlen(content), 0);
						if (send_result == SOCKET_ERROR)// �����ʹ���
						{
							cerr << "Server: Failed to send message to client " << Client->clientname << ". Error: " << WSAGetLastError() << endl;

						}
					}
				}
			}
		}
		else
		{
			cout<<"Server: Failed to receive message from client "<<Client->clientname<<". Error: " << WSAGetLastError() << endl;
			break;
		}
			
    }

	// ���б���ɾ���ͻ����׽���
	//lock_guard<mutex> lock2(mtx);
	//clientSockets.erase(remove(clientSockets.begin(), clientSockets.end(), Client->client), clientSockets.end());

	// �رտͻ����׽���
	closeSocket(Client->client_Socket);

	return 0;
}

int main()
{
	//��ʼ��WinSock��
	if (initializeWinSock() != 0)
	{
		cerr << "Server: WSAStartup failed. Error: " << WSAGetLastError() << endl;
		return 1;
	}

	//����һ��Socket�������ͻ��˵���������
	int serverPort = 5500;
	int serverSocket = createServerSocket(serverPort);

	if (serverSocket < 0)
	{
		cerr << "Server: Failed to create a server socket. Error: " << WSAGetLastError() << endl;
		cleanupWinSock();
		return 1;
	}
	else
	{
		cerr << "Server: Create a server socket. " << endl;
	}

	//�ȴ��ͻ��˵�����
	sockaddr_in clientAddr;
	int clientAddrLen = sizeof(clientAddr);

	while (true)
	{
		//CLIENT newClient;
		//newClient.client = acceptClient(serverSocket, &clientAddr, &clientAddrLen);
		//���ܿͻ��˵�����
		clients[num].client_Socket = acceptClient(serverSocket, &clientAddr, &clientAddrLen);
		clients[num].flag = num;
		//�����û����������Ƿ��ܳɹ�����
		recv(clients[num].client_Socket, clients[num].clientname, sizeof(clients[num].clientname), 0); //�����û���
		cout << clients[num].clientname << " connected" << endl;
		//receiveMessage(clients[num].client, clients[num].clientname);

		//clients.push_back();
		DWORD  lpThreadID;
		HANDLE clientThread;

		//�����̴߳�����Ϣ������ת��              
		clientThread = CreateThread(nullptr, 0, (LPTHREAD_START_ROUTINE)handleClient, &clients[num], 0, &lpThreadID);
		if (clientThread == nullptr)
		{
			cerr << "Server: Failed to create a thread. Error: " << GetCurrentThreadId() << endl;
		}
		else
		{
			cout << "Server:  a thread." << endl;
		}
		// ��Ǽ�һ
		num++;
		//lock_guard<mutex> lock(mtx); // ������������ȷ���̰߳�ȫ
		//clients.push_back(newClient);
	}

	//�����˳���ȷ���������ܹ������˳����ͷ���Դ�����ر����пͻ������ӡ�
	closeSocket(serverSocket); // �رշ������׽���
	cleanupWinSock(); // ����WinSock��

	return 0;
}
