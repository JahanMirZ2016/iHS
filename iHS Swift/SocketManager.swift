////
////  SocketManager.swift
////  UniPerLTD
////
////  Created by Ali Zare Sh on 10/18/16.
////  Copyright © 2016 BinMan1. All rights reserved.
////


import Foundation

protocol RecieveSocketDelegate : class {
    func recieve(rData : NSString)
}

enum SocketState {
    case none
    case disconnect
    case connectToServer
    case connectToLocal
    case tryConnecting
}

class SocketManager {
    
    // BinMan1 : Socket States
    var state = SocketState.none
    
    private var SOCKET_IP : NSString = ""
    private var SOCKET_PORT = -1
    
    weak var rDelegate : RecieveSocketDelegate?
    
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
    func send(stringData : NSString) -> Bool{
        if sendData(UnsafeMutablePointer<Int8>(stringData.UTF8String)) < 0 {
            return false
        }
        
        return true
    }
    
    /// Recieve data from socket server-side
    func recieve() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
//            var temp = UnsafeMutablePointer<UInt8>()
            var tempString = NSString()
            while true {
                let data = recieveData()
                if data[0] == 10 || data[0] == 13 {
                    self.rDelegate?.recieve(tempString)
                    tempString = ""
                    continue
                }
                
                if NSString(UTF8String: data) != "" && NSString(UTF8String: data) != nil {
                    tempString = (tempString as String) + (NSString(UTF8String : data) as! String)
                }
            }
        }
    }
    
    /// BinMan1 : Close socket connection
    
    func close() -> Bool {
        if closeSocket() < 0 {
            return false
        }
        
        return true
    }
}
