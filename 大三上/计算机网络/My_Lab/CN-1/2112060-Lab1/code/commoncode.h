#pragma once
#ifndef COMMONLIBRARY_H
#define COMMONLIBRARY_H

#include <WinSock2.h>
#include <iostream>
#include <string>
#include <cstring>
using namespace std;

extern int initializeWinSock();//���ڳ�ʼ��WinSock��Windows�׽��֣���
extern void cleanupWinSock();//��������WinSock��
extern SOCKET createServerSocket(int port);//���ڴ����������׽��֣�����Ĳ����Ƕ˿ں�
extern SOCKET acceptClient(SOCKET serverSocket, sockaddr_in* clientAddr, int* clientAddrLen);//���ڽ��ܿͻ����������󣬲����ؿͻ��˵��׽�����Ϣ��
extern int sendMessage(SOCKET socket,const char* message);//���ڷ���������Ϣ
extern int receiveMessage(SOCKET socket, char* message);//���ڽ���������Ϣ
extern void closeSocket(SOCKET socket);//���ڹر��׽���
extern SOCKET createClientSocket(const char* serverIP, int serverPort);//�����ͻ����׽���
extern string getTime();//���ڻ�ȡ��ǰʱ��
#endif // COMMONLIBRARY_H