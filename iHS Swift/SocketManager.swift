////
////  SocketManager.swift
////  UniPerLTD
////
////  Created by Ali Zare Sh on 10/18/16.
////  Copyright © 2016 BinMan1. All rights reserved.
////


import Foundation

protocol RecieveSocketDelegate {
    func recieve(rData : NSString)
}


class SocketManager {
    
    private var SOCKET_IP : NSString = ""
    private var SOCKET_PORT = -1
    
    var rDelegate : RecieveSocketDelegate?
    
    /// Open socket to ip and port of socket server-side
    func open(IP socketIP : String , Port socketPort : Int) -> Bool {
        SOCKET_IP = socketIP
        SOCKET_PORT = socketPort
        
        
        if connectToSocket(UnsafeMutablePointer<Int8>(SOCKET_IP.UTF8String) , Int32(SOCKET_PORT)) < 0 {
            return false
        }
        self.recieve()
        return true
    }
    
    /// Send string data to existing opened socket
    func send(stringData : NSString)->Bool {
        if sendData(UnsafeMutablePointer<Int8>(stringData.UTF8String)) < 0 {
            return false
        }
        
        return true
    }
    
    /// Recieve data from socket server-side
    func recieve() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            var temp = NSString()
            while true {
                let data = NSString(UTF8String: recieveData())
                if data != "" && data != nil {
                    temp = (temp as String) + (data! as String)
                    //                    if temp.lowercaseString.rangeOfString("]\n") != nil {
                    //                        self.rDelegate?.recieve(temp)
                    //                        Printer("Socket Data : \(temp.debugDescription)")
                    //                        temp = NSString()
                    //                    }
                    //
                    //                    if temp.lowercaseString.rangeOfString("}\n") != nil {
                    //                        self.rDelegate?.recieve(temp)
                    //                        Printer("Socket Data : \(temp.debugDescription)")
                    //                        temp = NSString()
                    //                    }
                } else {
                    if temp != "" {
                        Printer("Socket Data Recived : \(temp.debugDescription)")
                        temp = NSString()
                    }
                }
            }
        }
    }
}
