//
//  Socket.h
//  UniPerLTD
//
//  Created by Ali Zare Sh on 10/18/16.
//  Copyright © 2016 BinMan1. All rights reserved.
//

#ifndef Socket_h
#define Socket_h

#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <string.h>
#include <unistd.h>
#include<arpa/inet.h>

struct sockaddr_in server_in;
int sock, conn;
//struct hostent *server;
char buffer[10];


int connectToSocket(char* server_ip , int server_port);
long sendData(char* message);
char* recieveData();
int closeSocket();
char* concat(const char *a, const char *b);

#endif /* Socket_h */
