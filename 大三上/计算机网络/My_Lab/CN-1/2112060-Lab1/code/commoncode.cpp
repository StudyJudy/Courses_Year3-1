#include <iostream>
#include <vector>
#include <string>
#include <thread>
#include <cstring>
#include <cstdlib>
#include <mutex>
#include <WinSock2.h>
#include <ws2tcpip.h>

#pragma comment(lib, "ws2_32.lib")

using namespace std;

// ��ʼ��WinSock��
int initializeWinSock()
{
	cout << "commoncode: Initializing WinSock..." << endl;
	WSADATA wsaData; //wsaData�����洢ϵͳ���صĹ���WINSOCK������.
	if (WSAStartup(MAKEWORD(2, 2), &wsaData) != 0)//MAKEWORD(2, 2)��ʾʹ��WINSOCK2�汾.
	{
		cout << "commoncode: WSAStartup failed." << endl;
		return -1;
	}
	else
	{
		cout << "commoncode: WSAStartup is successful." << endl;
		return 0;
	}
}

// ����WinSock����Դ
void cleanupWinSock()
{
	cout << "commoncode: Cleaning up WinSock..." << endl;
	WSACleanup();
}

// �ر��׽���
void closeSocket(SOCKET socket)
{
	cout << "commoncode: Closing socket..." << endl;
	closesocket(socket);
}

// �����������׽���
SOCKET createServerSocket(int port)
{
	cout << "commoncode: Creating server socket..." << endl;
	// ����һ���׽��֣�ʹ��IPv4��ַ��(AF_INET)����ʽ�׽�������(SOCK_STREAM)����TCPЭ��(IPPROTO_TCP)
	SOCKET serverSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	if (serverSocket == INVALID_SOCKET)
	{
		cerr << "commoncode: Create socket failed. Error: " << WSAGetLastError() << endl;
		return -1;// ����-1��ʾ�����׽���ʧ��
	}

	// ���÷�������ַ�ṹ
	sockaddr_in serverAddr;//ͨ���׽��ֵ�ַ
	serverAddr.sin_family = AF_INET;// ��ַ�壬IPv4
	serverAddr.sin_port = htons(port);//�˿ںţ���Ҫʹ��htons�������˿ںŴ������ֽ���ת��Ϊ�����ֽ���
	serverAddr.sin_addr.s_addr = INADDR_ANY;//ip��ַ��INADDR_ANY ��ʾ�׽��ֿ��Խ������Ա����ϵ���������ӿڣ������п��õ� IP ��ַ������������

	// ����SO_REUSEADDRѡ������������͡�����״̬�׽ӿڵ�����ѡ��ֵ���������׽��ֵ�ַ������
	int reuse = 1;
	if (setsockopt(serverSocket, SOL_SOCKET, SO_REUSEADDR, (const char*)&reuse, sizeof(int)) == SOCKET_ERROR)
	{
		cerr << "commoncode: Setsockopt failed. Error: " << WSAGetLastError() << endl;
		closesocket(serverSocket);
		return -4;// ����-4��ʾ����ѡ��ʧ��
	}
	else
	{
		cout << "commoncode: Setsockopt." << endl;
	}

	//���׽��ְ󶨵�ָ���Ķ˿ں�IP��ַ
	if (bind(serverSocket, (struct sockaddr*)&serverAddr, sizeof(serverAddr)) == SOCKET_ERROR)
	{
		cerr << "commoncode: Bind failed. Error: " << WSAGetLastError() << endl;
		closesocket(serverSocket);
		return -2;
	}
	else
	{
		cout << "commoncode: Bind." << endl;
	}

	// ��ʼ�������������������10���ȴ�����
	if (listen(serverSocket, 10) == SOCKET_ERROR)
	{
		cerr << "commoncode: Listen failed. Error: " << WSAGetLastError() << endl;
		closesocket(serverSocket);
		return -3;// ����-3��ʾ����ʧ��
	}
	else
	{
		cout << "commoncode: Listen." << endl;
	}

	return serverSocket;// ���ش����ķ������׽���
}

// �����ͻ����׽���
SOCKET createClientSocket(const char* serverIP, int serverPort)
{
	SOCKET clientSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	if (clientSocket == INVALID_SOCKET)
	{
		cerr << "commoncode: Failed to create a client socket. Error: " << WSAGetLastError() << endl;
		cleanupWinSock();
		return -2;
	}

	sockaddr_in serverAddr;
	serverAddr.sin_family = AF_INET;
	serverAddr.sin_port = htons(serverPort);

	// ���������� IP ��ַ
	if (inet_pton(AF_INET, serverIP, &serverAddr.sin_addr) <= 0)
	{
		cerr << "commoncode: Failed to resolve server IP address. Error: " << WSAGetLastError() << endl;
		closeSocket(clientSocket);
		cleanupWinSock();
		return -3;
	}
	else
	{
		cout << "commoncode: Resolve server IP address." << endl;
	}

	// �������ӵ�������
	if (connect(clientSocket, (struct sockaddr*)&serverAddr, sizeof(serverAddr)) < 0)
	{
		cerr << "commoncode: Failed to connect to the server. Error: " << WSAGetLastError() << endl;
		closeSocket(clientSocket);
		cleanupWinSock();
		return -4;
	}
	else
	{
		cout << "commoncode: Connect to the server." << endl;
	}

	return clientSocket;
}

// ���ܿͻ�������
SOCKET acceptClient(SOCKET serverSocket, sockaddr_in* clientAddr, int* clientAddrLen)
{
	cout << "commoncode: Accepting client connection..." << endl;
	// ʹ�� accept �������ܿͻ��˵��������󣬷���һ���µ��׽���������ͻ���ͨ��
	SOCKET clientSocket = accept(serverSocket, (struct sockaddr*)clientAddr, clientAddrLen);
	// ����Ƿ������������ʧ��
	if (clientSocket == SOCKET_ERROR)
	{
		cerr << "commoncode: Accept failed. Error: " << WSAGetLastError() << endl;
		return -1;// ����-1��ʾ��������ʧ��
	}
	cout << "commoncode: Client connected." << endl;
	return clientSocket;// ������ͻ���ͨ�ŵ��׽���
}

// ������Ϣ���׽���
int sendMessage(SOCKET socket, const char* message)
{
	cout << "commoncode: Sending message..." << endl;
	int bytesSent = send(socket, message, sizeof(message), 0);
	if (bytesSent == SOCKET_ERROR)
	{
		cerr << "commoncode: Error sending message. Error code: " << WSAGetLastError() << endl;
	}
	return bytesSent;
}

// ���׽��ֽ�����Ϣ
int receiveMessage(SOCKET socket, char* message)
{
	cout << "commoncode: Receiving message..." << endl;
	int bytesRead = recv(socket, message, sizeof(message), 0);
	if (bytesRead == SOCKET_ERROR)
	{
		cerr << "commoncode: Error receiving message. Error code: " << WSAGetLastError() << endl;
	}
	return bytesRead;
}

string getTime()
{
	// ��ȡϵͳʱ��
	time_t rawtime;
	struct tm timeInfo;
	char time_buffer[64];

	time(&rawtime);
	localtime_s(&timeInfo, &rawtime);
	strftime(time_buffer, sizeof(time_buffer), "%Y-%m-%d %H:%M:%S", &timeInfo);

	return string(time_buffer);
}