//
//  Internet.swift
//  iHS Swift
//
//  Created by Ali Zare Sh on 11/24/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import Foundation
import SystemConfiguration.CaptiveNetwork
import UIKit
import CoreLocation

class Internet {
    
    private var network : Reachability!
    private var timer : NSTimer!
    
    
    func checkNetwork() {
        timer = NSTimer(timeInterval: 30, target: self, selector: #selector(self.GPS), userInfo: nil, repeats: true)
        self.checking()
    }
    
    private func checking() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.reachabilityChanged(_:)), name: kReachabilityChangedNotification, object: nil)
        
        self.network = Reachability.reachabilityForInternetConnection()
        self.network.startNotifier()
        self.updateInterfaceWithReachability(network)
    }
    
    
    @objc private func reachabilityChanged(notification : NSNotification) {
        let net = notification.object as! Reachability
        self.updateInterfaceWithReachability(net)
    }
    
    private func updateInterfaceWithReachability(reachability : Reachability) {
        let netStatus = reachability.currentReachabilityStatus()
        
        if netStatus == NotReachable {
            let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
            
            // BinMan1 : in this case, because of have any internet connection socket should close
            if appDel.socket != nil {
                if appDel.socket.state == .connectToServer || appDel.socket.state == .connectToLocal {
                    appDel.socket.close()
                    timer.invalidate()
                }
                
                appDel.socket = nil
            }
        } else if netStatus == ReachableViaWiFi {
            // BinMan1 : Check that wifi is the center wifi and we are in the local network
            let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
            guard isConnectToLocalWifi() else {
                // BinMan1 : socket should connect to server socket
                let serverIP = DBManager.getValueOfSettingsDB(Type: TypeOfSettings.ServerIP)!
                let serverPort = Int(DBManager.getValueOfSettingsDB(Type: TypeOfSettings.ServerPort)!)!
                if appDel.socket == nil {
                    appDel.socket = SocketManager()
                }
                
                if appDel.socket.state == .none || appDel.socket.state == .disconnect {
                    if appDel.socket.open(IP: serverIP, Port: serverPort) {
                        timer.fire()
                        appDel.socket.state = .connectToServer
                        return
                    }
                }
                
                if appDel.socket.state == .connectToLocal {
                    if appDel.socket.close() {
                        timer.invalidate()
                        if appDel.socket.open(IP: serverIP, Port: serverPort) {
                            appDel.socket.state = .connectToServer
                            timer.fire()
                            return
                        }
                    }
                }
                
                return
            }
            
            // BinMan1 : socket should connect to local socket connection
            let centerIP = DBManager.getValueOfSettingsDB(Type: TypeOfSettings.CenterIP)!
            let centerPort = Int(DBManager.getValueOfSettingsDB(Type: TypeOfSettings.CenterPort)!)!
            
            if appDel.socket == nil {
                appDel.socket = SocketManager()
            }
            
            if appDel.socket.state == .none || appDel.socket.state == .disconnect {
                if appDel.socket.open(IP: centerIP, Port: centerPort) {
                    timer.fire()
                    appDel.socket.state = .connectToLocal
                    return
                }
            }
            
            if appDel.socket.state == .connectToServer {
                if appDel.socket.close() {
                    timer.invalidate()
                    if appDel.socket.open(IP: centerIP, Port: centerPort) {
                        timer.fire()
                        appDel.socket.state = .connectToLocal
                        return
                    }
                }
            }
        } else { // BinMan1 : socket should connect to server socket
            let serverIP = DBManager.getValueOfSettingsDB(Type: TypeOfSettings.ServerIP)!
            let serverPort = Int(DBManager.getValueOfSettingsDB(Type: TypeOfSettings.ServerPort)!)!
            let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
            
            if appDel.socket == nil {
                appDel.socket = SocketManager()
            }
            
            if appDel.socket.state == .none || appDel.socket.state == .disconnect {
                if appDel.socket.open(IP: serverIP, Port: serverPort) {
                    timer.fire()
                    appDel.socket.state = .connectToServer
                    return
                }
            }
            
            if appDel.socket.state == .connectToLocal {
                if appDel.socket.close() {
                    timer.invalidate()
                    if appDel.socket.open(IP: serverIP, Port: serverPort) {
                        timer.fire()
                        appDel.socket.state = .connectToServer
                        return
                    }
                }
            }
        }
    }
    
    
    /// BinMan1 : Check wifi connection is in the local network or not
    private func isConnectToLocalWifi () -> Bool {
        
        let DBSSID = DBManager.getValueOfSettingsDB(Type: TypeOfSettings.WiFiSSID)
        let DBBSSID = DBManager.getValueOfSettingsDB(Type: TypeOfSettings.WiFiMac)
        let (currentWifiSSID , currentWifiBSSID) = fetchSSIDAndBSSIDInfo()
        
        if DBSSID == currentWifiSSID && DBBSSID == currentWifiBSSID {
            return true
        }
        
        return false
    }
    
    /// BinMan1 : Get wifi SSID and wifi BSSID (Mac address)
    private func fetchSSIDAndBSSIDInfo() -> (String , String) {
        var currentSSID = ""
        var currentBSSID = ""
        if let interfaces = CNCopySupportedInterfaces() {
            for i in 0..<CFArrayGetCount(interfaces) {
                let interfaceName: UnsafePointer<Void> = CFArrayGetValueAtIndex(interfaces, i)
                let rec = unsafeBitCast(interfaceName, AnyObject.self)
                let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)")
                if unsafeInterfaceData != nil {
                    let interfaceData = unsafeInterfaceData! as Dictionary!
                    currentSSID = interfaceData["SSID"] as! String
                    currentBSSID = interfaceData["BSSID"] as! String
                }
            }
        }
        return (currentSSID , currentBSSID)
    }
    
    /// Arash: Send location data.
    @objc func GPS() {
        locationManager = CLLocationManager()
        locationManager!.distanceFilter = kCLDistanceFilterNone // whenever we move
        locationManager!.desiredAccuracy = kCLLocationAccuracyHundredMeters // 100 m
        locationManager!.requestAlwaysAuthorization()
        locationManager!.startUpdatingLocation()
        
        let mobileID = DBManager.getValueOfSettingsDB(Type: "MobileID")
        var array = Array<NSDictionary>()
        let dic:NSDictionary = ["MobileID" : mobileID! , "Latitude" : String(locationManager!.location!.coordinate.latitude) , "Longitude" : String(locationManager!.location!.coordinate.longitude)]
        array.append(dic)
        let dic2:NSDictionary = ["GPSAnnounce" : array , "MessageID" : "0" , "RecieverID" : mobileID! , "Type" : "GPSAnnounce" , "Action" : "Update" , "Date" : "2015-01-01 12:00:00"]
        var array2 = Array<NSDictionary>()
        array2.append(dic2)
        let jsonData = JsonMaker.arrayToJson(array2)
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    
        appDel.socket.send(jsonData)
    }
}
