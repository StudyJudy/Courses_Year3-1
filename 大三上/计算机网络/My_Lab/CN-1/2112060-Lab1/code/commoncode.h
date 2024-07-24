#pragma once
#ifndef COMMONLIBRARY_H
#define COMMONLIBRARY_H

#include <WinSock2.h>
#include <iostream>
#include <string>
#include <cstring>
using namespace std;

extern int initializeWinSock();//用于初始化WinSock（Windows套接字）库
extern void cleanupWinSock();//用于清理WinSock库
extern SOCKET createServerSocket(int port);//用于创建服务器套接字，传入的参数是端口号
extern SOCKET acceptClient(SOCKET serverSocket, sockaddr_in* clientAddr, int* clientAddrLen);//用于接受客户端连接请求，并返回客户端的套接字信息。
extern int sendMessage(SOCKET socket,const char* message);//用于发送聊天消息
extern int receiveMessage(SOCKET socket, char* message);//用于接收聊天消息
extern void closeSocket(SOCKET socket);//用于关闭套接字
extern SOCKET createClientSocket(const char* serverIP, int serverPort);//创建客户端套接字
extern string getTime();//用于获取当前时间
#endif // COMMONLIBRARY_H