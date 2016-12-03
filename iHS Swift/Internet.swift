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

class Internet :  NSObject ,CLLocationManagerDelegate{
    
    private var network : Reachability!
    private var locationManager:CLLocationManager!
    //    private var timer : NSTimer!
    
    
    func checkNetwork() {
        //        timer = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: #selector(self.GPS), userInfo: nil, repeats: true)
        self.checking()
    }
    
    
    private func checking() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.reachabilityChanged(_:)), name: ReachabilityChangedNotification, object: nil)
        do {
            self.network = try Reachability(hostname: "https://www.google.com")
            try self.network.startNotifier()
        } catch let err as NSError {
            Printer("reachability error : \(err.debugDescription)")
        }
    }
    
    
    @objc private func reachabilityChanged(notification : NSNotification) {
        let net = notification.object as! Reachability
        self.updateInterfaceWithReachability(net)
    }
    
    private func updateInterfaceWithReachability(reachability : Reachability) {
        let netStatus = reachability.currentReachabilityStatus
        
        if netStatus == Reachability.NetworkStatus.NotReachable {
            let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
            
            // BinMan1 : in this case, because of have any internet connection socket should close
            if appDel.socket != nil {
                if appDel.socket.state == .connectToServer || appDel.socket.state == .connectToLocal {
                    appDel.socket.close()
                    timer.invalidate()
                    
                }
                
                appDel.socket = nil
                
                let state = ActionBarState.noInternetConnection
                NSNotificationCenter.defaultCenter().postNotificationName(ACTIONBAR_UPDATE_VIEW, object: state as? AnyObject)
            }
        } else if netStatus == Reachability.NetworkStatus.ReachableViaWiFi {
            // BinMan1 : Check that wifi is the center wifi and we are in the local network
            let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
            guard isConnectToLocalWifi() else {
                
                let state = ActionBarState.globalConnection
                NSNotificationCenter.defaultCenter().postNotificationName(ACTIONBAR_UPDATE_VIEW, object: state as? AnyObject)
                
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
            
            let state = ActionBarState.localConnection
            NSNotificationCenter.defaultCenter().postNotificationName(ACTIONBAR_UPDATE_VIEW, object: state as? AnyObject)
            
            // BinMan1 : socket should connect to local socket connection
            let centerIP = DBManager.getValueOfSettingsDB(Type: TypeOfSettings.CenterIP)!
            let centerPort = Int(DBManager.getValueOfSettingsDB(Type: TypeOfSettings.CenterPort)!)!
            
            if appDel.socket == nil {
                appDel.socket = SocketManager()
            }
            
            if appDel.socket.state == .none || appDel.socket.state == .disconnect {
                if appDel.socket.open(IP: centerIP, Port: centerPort) {
                    //                    timer.fire()
                    appDel.socket.state = .connectToLocal
                    SendCustomerId()
                    Sync()
                    return
                }
            }
            
            if appDel.socket.state == .connectToServer {
                if appDel.socket.close() {
                    timer.invalidate()
                    if appDel.socket.open(IP: centerIP, Port: centerPort) {
                        timer.fire()
                        appDel.socket.state = .connectToLocal
                        SendCustomerId()
                        Sync()
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
        
        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
            for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                    currentSSID = (interfaceInfo[kCNNetworkInfoKeySSID as String] as? String)!
                    currentBSSID = (interfaceInfo[kCNNetworkInfoKeyBSSID as String] as? String)!
                }
            }
        }
        return (currentSSID , currentBSSID)
    }
    
    /// Arash: Send location data.
    @objc func GPS() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager!.distanceFilter = kCLDistanceFilterNone // whenever we move
        locationManager!.desiredAccuracy = kCLLocationAccuracyHundredMeters // 100 m
        locationManager!.requestAlwaysAuthorization()
        locationManager!.startUpdatingLocation()
        
        
    }
    
    
    public func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        let lang = location?.coordinate.longitude
        let lat = location?.coordinate.latitude
        
        let mobileID = DBManager.getValueOfSettingsDB(Type: "MobileID")
        var array = Array<NSDictionary>()
        let dic:NSDictionary = ["MobileID" : mobileID! , "Latitude" : String(lat) , "Longitude" : String(lang)]
        array.append(dic)
        let dic2:NSDictionary = ["GPSAnnounce" : array , "MessageID" : "0" , "RecieverID" : mobileID! , "Type" : "GPSAnnounce" , "Action" : "Update" , "Date" : "2015-01-01 12:00:00"]
        var array2 = Array<NSDictionary>()
        array2.append(dic2)
        let jsonData = JsonMaker.arrayToJson(array2)
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDel.socket.send(jsonData)
    }
}
