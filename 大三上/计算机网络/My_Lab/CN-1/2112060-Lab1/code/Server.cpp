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
	SOCKET client_Socket;//客户端套接字  
	char clientname[20];//客户名
	char time_stamp[64];//当前时间的字符串
	char content_buf[256];//客户端收到信息后服务器端显示及发送的字符串
	int flag;//当前客户端标号
}CLIENT;

//vector<int> clientSockets;// 存储连接的客户端套接字
CLIENT clients[20];//聊天室最多20人
//mutex mtx; // 互斥锁，用于保护 clientSockets 向量，确保多线程访问时的同步。
//vector<CLIENT> clients;

int num = 0;//当前客户端的标记

// 处理单个客户端的线程
DWORD WINAPI handleClient(LPVOID lpParam)
{
	CLIENT* Client = (CLIENT*)lpParam; // 声明并初始化一个 CLIENT 指针
	char timestamp[64] = {};  // 时间戳，可以是字符串或时间格式
	char content[256];   // 接收的聊天消息内容
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

		//接收数据
		int recv_time = recv(Client->client_Socket, timestamp, sizeof(timestamp), 0);
		int recv_con = recv(Client->client_Socket, content, sizeof(content), 0);
		//int recv_time = receiveMessage(Client->client, timestamp);
		//int ret_con = receiveMessage(Client->client, content);
		
		//拼接服务器端收到消息的显示格式
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
			//服务器端的显示
			cout << Client->content_buf << endl;

			//lock_guard<mutex> lock(mutex);//使用互斥锁以确保多个线程安全地操作 clients vector,保护共享资源 clients

			if (strcmp(content, "exit_request") != 0)
			{
				for (i = 0; i < num; i++)
				{
					if (i != Client->flag)
					{
						// 发送回复消息给客户端 
						SOCKET send_result = send(clients[i].client_Socket, Client->content_buf, strlen(Client->content_buf), 0);
						//sendMessage(Client->client, Client->buf);
						if (send_result == SOCKET_ERROR)// 处理发送错误
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
						if (send_result == SOCKET_ERROR)// 处理发送错误
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

	// 从列表中删除客户端套接字
	//lock_guard<mutex> lock2(mtx);
	//clientSockets.erase(remove(clientSockets.begin(), clientSockets.end(), Client->client), clientSockets.end());

	// 关闭客户端套接字
	closeSocket(Client->client_Socket);

	return 0;
}

int main()
{
	//初始化WinSock库
	if (initializeWinSock() != 0)
	{
		cerr << "Server: WSAStartup failed. Error: " << WSAGetLastError() << endl;
		return 1;
	}

	//创建一个Socket来监听客户端的连接请求。
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

	//等待客户端的连接
	sockaddr_in clientAddr;
	int clientAddrLen = sizeof(clientAddr);

	while (true)
	{
		//CLIENT newClient;
		//newClient.client = acceptClient(serverSocket, &clientAddr, &clientAddrLen);
		//接受客户端的连接
		clients[num].client_Socket = acceptClient(serverSocket, &clientAddr, &clientAddrLen);
		clients[num].flag = num;
		//接收用户名，检验是否能成功接收
		recv(clients[num].client_Socket, clients[num].clientname, sizeof(clients[num].clientname), 0); //接收用户名
		cout << clients[num].clientname << " connected" << endl;
		//receiveMessage(clients[num].client, clients[num].clientname);

		//clients.push_back();
		DWORD  lpThreadID;
		HANDLE clientThread;

		//创建线程处理消息接收与转发              
		clientThread = CreateThread(nullptr, 0, (LPTHREAD_START_ROUTINE)handleClient, &clients[num], 0, &lpThreadID);
		if (clientThread == nullptr)
		{
			cerr << "Server: Failed to create a thread. Error: " << GetCurrentThreadId() << endl;
		}
		else
		{
			cout << "Server:  a thread." << endl;
		}
		// 标记加一
		num++;
		//lock_guard<mutex> lock(mtx); // 锁定互斥锁，确保线程安全
		//clients.push_back(newClient);
	}

	//正常退出：确保服务器能够正常退出，释放资源，并关闭所有客户端连接。
	closeSocket(serverSocket); // 关闭服务器套接字
	cleanupWinSock(); // 清理WinSock库

	return 0;
}
