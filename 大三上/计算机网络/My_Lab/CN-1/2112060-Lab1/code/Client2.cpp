#include <iostream>
#include <vector>
#include <string>
#include <thread>
#include <cstring>
#include <cstdlib>
#include <mutex>
#include<cmath>
#include <limits>
#include <ios>
#include <WinSock2.h>
#include <ws2tcpip.h>
#include "commoncode.h"

#pragma comment(lib, "ws2_32.lib")

using namespace std;
//HWND hEdit;
//HWND hButton;
wstring chatHistory;
SOCKET clientSocket;  // ��clientSocket����Ϊȫ�ֱ���

// ��Ϣ������
/*LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
	switch (msg)
	{
	case WM_CREATE:
		hEdit = CreateWindowEx(WS_EX_CLIENTEDGE, L"EDIT", L"", WS_CHILD | WS_VISIBLE | WS_VSCROLL | ES_MULTILINE | ES_AUTOVSCROLL,
			10, 10, 400, 200, hwnd, (HMENU)1, NULL, NULL);
		hButton = CreateWindow(L"BUTTON", L"Send", WS_CHILD | WS_VISIBLE, 10, 220, 80, 30, hwnd, (HMENU)2, NULL, NULL);
		return 0;

	case WM_COMMAND:
		if (LOWORD(wParam) == 2) // Send��ť�����
		{
			wchar_t buffer[256];
			GetWindowText(hEdit, buffer, 256);
			// ����Ϣ���͵�������
			string message(buffer, buffer + wcslen(buffer));
			int sendResult = send(clientSocket, message.c_str(), message.size(), 0);
			if (sendResult == SOCKET_ERROR) {
				cerr << "Client: Failed to send message to server. Error: " << WSAGetLastError() << endl;
			}
			//chatHistory += wstring(buffer) + L"\r\n";
			SetWindowText(hEdit, L"");
			//SetWindowText(hEdit, chatHistory.c_str());

			// ���ı����ȡ��Ϣ
			wstring message(buffer);

			// ����Ϣ���͵�������
			string messageStr(message.begin(), message.end());
			send(clientSocket, messageStr.c_str(), messageStr.length(), 0);
		}
		return 0;

	case WM_DESTROY:
		PostQuitMessage(0);
		closesocket(clientSocket);
		WSACleanup();
		return 0;
	}
	return DefWindowProc(hwnd, msg, wParam, lParam);
}*/

bool exitRequested = false;

// �ͻ����̣߳����ڽ�����Ϣ
DWORD WINAPI Client_Receive(LPVOID lparam)
{
	SOCKET Client = (SOCKET)(LPVOID)lparam;
	char messagebuffer[256] = { 0 };
	int recv_buffer = 0;

	while (true)
	{
		memset(messagebuffer, 0, sizeof(messagebuffer));
		//int rec=receiveMessage(Client, messagebuffer);
		recv_buffer = recv(Client, messagebuffer, sizeof(messagebuffer), 0);

		if (recv_buffer < 0)
		{
			cout << "Client: Failed to receive the message. Error: " << WSAGetLastError() << endl;
			break;
		}
		else
		{
			if (strcmp(messagebuffer, "exit_request") == 0)
			{
				cout << "Client: Server confirmed exit. Closing the connection..." << endl;
				closeSocket(Client);
				cleanupWinSock();
				break;
				return 0;
			}

			else
			{
				cout << "Client: " << messagebuffer << "��Broadcast��" << endl;
			}
		}

	}
	// �رտͻ����׽��ֺ��߳��˳�
	//closeSocket(Client);
	return 0;
}

char clientname[20] = { 0 };

DWORD WINAPI Client_Send(LPVOID lparam)
{
	SOCKET clientSocket = (SOCKET)(LPVOID)lparam;
	char message[256] = { 0 };
	char SendTime[64] = {};
	int send_time = 0;
	int send_message = 0;
	int send_exit = 0;
	char Exit[15];
	strcpy_s(Exit, sizeof(Exit), "exit_request");

	while (true && (exitRequested == false))
	{
		memset(message, 0, sizeof(message));
		memset(clientname, 0, sizeof(clientname));
		memset(SendTime, 0, sizeof(SendTime));

		string time = getTime();//��ȡ��ǰʱ��
		strcpy_s(SendTime, sizeof(SendTime), time.c_str());

		cin.ignore((numeric_limits<streamsize>::max)(), '\n');

		cout << SendTime << " " << clientname << ": ";
		cout << "Client: Enter your message (type 'exit' if you want to exit): ";
		cin.getline(message, sizeof(message));

		cin.ignore((numeric_limits<streamsize>::max)(), '\n');

		if (strcmp(message, "exit") == 0)
		{
			send_time = send(clientSocket, SendTime, strlen(SendTime), 0);
			//send_message = send(clientSocket, message, strlen(message), 0);
			// ����������˳�������Ϣ��������			
			send_exit = send(clientSocket, Exit, strlen(Exit), 0);
			if (send_exit == SOCKET_ERROR)
			{
				cerr << "Client: Failed to send exit request. Error: " << WSAGetLastError() << endl;
				// ������Կ��ǽ��д������������·��ͻ�ر�����
			}
			else
			{
				cout << "Exit request sent." << endl;
			}
			//send(clientSocket, "exit_request", strlen("exit_request"), 0);
			exitRequested = true;
			return 0;
		}
		else
		{
			send_time = send(clientSocket, SendTime, strlen(SendTime), 0);
			send_message = send(clientSocket, message, strlen(message), 0);
		}
	}
	return 0;
}

int main()
{
	//��ʼ��WinSock��
	if (initializeWinSock() != 0)
	{
		cerr << "Client: WSAStartup failed. Error: " << WSAGetLastError() << endl;
		return 1;
	}

	/*// ����������
	WNDCLASSEX wc = { sizeof(WNDCLASSEX), CS_CLASSDC, WndProc, 0L, 0L, GetModuleHandle(NULL), NULL, NULL, NULL, NULL, L"ChatClient", NULL };
	RegisterClassEx(&wc);

	// ��������
	HWND hwnd = CreateWindow(wc.lpszClassName, L"Chat Client", WS_OVERLAPPEDWINDOW, 100, 100, 450, 400, NULL, NULL, wc.hInstance, NULL);

	// ��ʾ����
	ShowWindow(hwnd, SW_SHOWDEFAULT);
	UpdateWindow(hwnd);*/

	//����Socket���ڿͻ��˴���һ��Socket�����ӷ�������
	SOCKET clientSocket = createClientSocket("127.0.0.1", 5500);
	if ((clientSocket == -2) || (clientSocket == -3) || (clientSocket == -4))
	{
		closeSocket(clientSocket);// �رտͻ����׽���
		cleanupWinSock();// ����WinSock��	
		return 0;
	}
	cout << "########## message ##########" << endl;

	//memset(clientname, 0, sizeof(clientname));
	cout << "Client: Enter your name: ";
	cin >> clientname;
	cin.ignore((numeric_limits<streamsize>::max)(), '\n');
	send(clientSocket, clientname, strlen(clientname), 0);

	HANDLE  ThreadReceive, ThreadSend;

	ThreadReceive = CreateThread(NULL, 0, Client_Receive, (LPVOID)clientSocket, 0, NULL);
	ThreadSend = CreateThread(NULL, 0, Client_Send, (LPVOID)clientSocket, 0, NULL);

	// ʹ���߳�ͬ���ȴ��߳��˳�
	WaitForSingleObject(ThreadReceive, INFINITE);
	WaitForSingleObject(ThreadSend, INFINITE);

	//���̹رգ�����������
	if (WaitForSingleObject(ThreadReceive, INFINITE) == WAIT_OBJECT_0 ||
		WaitForSingleObject(ThreadSend, INFINITE) == WAIT_OBJECT_0)
	{
		CloseHandle(ThreadReceive);
		CloseHandle(ThreadSend);
		return 0;
	}

	//�����˳���ȷ���ͻ����ܹ������˳����ͷ���Դ��
	closeSocket(clientSocket);// �رտͻ����׽���
	cleanupWinSock();// ����WinSock��

	return 0;
}
