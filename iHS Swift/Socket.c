//
//  Socket.c
//  UniPerLTD
//
//  Created by Ali Zare Sh on 10/18/16.
//  Copyright © 2016 BinMan1. All rights reserved.
//

#include "Socket.h"



int connectToSocket(char* server_ip , int server_port) {
    sock = socket(AF_INET, SOCK_STREAM, 0);
    
    if (sock < 0) {
        printf("Can't make an empty socket\n");
        return sock;
    }
    
    server_in.sin_addr.s_addr = inet_addr(server_ip);
    server_in.sin_family = AF_INET;
    server_in.sin_port = htons(server_port);
    
    
    conn = connect(sock, (struct sockaddr *) &server_in, sizeof(server_in));
    
    if (conn < 0) {
        printf("Can not connect to server\n");
        return conn;
    }
    
    printf("Connect to socket successfully\n\n");
    return 1;
}



long sendData(char* message) {
    long status = send(sock, message, strlen(message), 0);
    return status;
}

char* recieveData() {
        memset(buffer, 0, sizeof(buffer));
        long int index;
        char* result = "";
    while ((index = recv(sock, buffer, sizeof(buffer), 0)) > 0) {
        result = concat(result, buffer);
        memset(buffer, 0, sizeof(buffer));
        if (((result[strlen(result)-1] == 10 || result[strlen(result)-1] == 13 ))) {
            break;
        }
    }
        if (index < 0) {
            return "RecieveFailed";
        }
    
        
        return result;
    }


int closeSocket() {
    return close(sock);
}

///Arash: Concatenate 2 strings.
char* concat(const char *a, const char *b)
{
    char *result = malloc(strlen(a)+strlen(b)+1);//+1 for the zero-terminator
    //in real code you would check for errors in malloc here
    strcpy(result, a);
    strcat(result, b);
    return result;
}
