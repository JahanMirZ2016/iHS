//
//  Socket.h
//  UniPerLTD
//
//  Created by Ali Zare Sh on 10/18/16.
//  Copyright © 2016 BinMan1. All rights reserved.
//

#ifndef Socket_h
#define Socket_h


#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <string.h>
#include<arpa/inet.h>

struct sockaddr_in server_in;
int sock, conn;
//struct hostent *server;
char buffer[256];


int connectToSocket(char* server_ip , int server_port);
long sendData(char* message);
char* recieveData();

#endif /* Socket_h */
