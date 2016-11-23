//
//  A.swift
//  iHS Swift
//
//  Created by Ali Zare Sh on 11/10/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

var locationManager:CLLocationManager?


/// Height of Phone screan
let HEIGHTPHONE = UIScreen.mainScreen().bounds.height

/// Width of Phone screan
let WIDTHPHONE = UIScreen.mainScreen().bounds.width


/// Name of DB
let DBNAME = "IHS15.sqlite"

/// Get DB From db path for all uses
func GetDBFromPath () -> FMDatabase? {
    
    let fileManager = NSFileManager.defaultManager()
    var dbPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
    dbPath = dbPath.stringByAppendingString("/\(DBNAME)")
    
    if fileManager.fileExistsAtPath(dbPath) {
        return FMDatabase(path: dbPath)
    } else {
        do {
            let path = NSBundle.mainBundle().resourcePath!.stringByAppendingString("/\(DBNAME)")
            try fileManager.copyItemAtPath(path, toPath: dbPath)
            return FMDatabase(path: dbPath)
        } catch let error as NSError {
            Printer("Make DB Error : \(error.debugDescription)")
            return nil
        }
    }
    
}

/// Language ID Selected By User
var SELECTEDLANGID = -1

/// Language ID FOR DB
struct LangID {
    static let ENGLISH = 1
    static let PERSIAN = 2
    static let ARABIC = 3
    static let TURKISH = 4
}


/// Print everything to console logs
func Printer(object : AnyObject) {
    print(object)
}


/// BinMan1 : A function for Set language ID From db to global variable
func SetLangIDToVar(id : Int) {
    SELECTEDLANGID = id
}

/// Arash: A function to sync and send data.
func Sync() -> Bool {
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    // Arash : Creating SyncDataModel
    let lastMessageID = "0"
    let appVerCode = "1"
    let languageID = "1"
    let mobileID = 26
    
    var arrayMain = Array<NSDictionary>()
    var array = Array<NSDictionary>()
    
    let dic2:NSDictionary = ["LastMessageID" : lastMessageID , "AppVerCode" : appVerCode , "LanguageID" : languageID]
    array.append(dic2)
    
    let dic3:NSDictionary = ["SyncData" : array , "MessageID" : "0" , "RecieverID" : mobileID , "Type" : "SyncData" , "Action" : "Update" , "Date" : "2015-01-01 12:00:00"]
    arrayMain.append(dic3)
    
    let jsonData = JsonMaker.arrayToJson(arrayMain)
    Printer("Sync : \(jsonData.debugDescription)")
    return appDel.socket.send(jsonData)
}

/// Arash: Send customer id.
func SendCustomerId() -> Bool {
    let customerID = 30242
    let mobileID = 26
    let exKey = "BF7E00CC32AFBDBD084AC3BBE2575CA5"
    
    let dic:Dictionary<String , AnyObject> = ["CustomerID" : customerID , "MobileID" : mobileID , "ExKey" : exKey]
    
    var array = [Dictionary<String , AnyObject>]()
    array = [dic]
    
    let jsonData = JsonMaker.arrayToJson(array)
    
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    
    return appDel.socket.send(jsonData)
}

/// Arash: Send location data.
func GPS() -> Bool {
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
    
    let returnBool = appDel.socket.send(jsonData)
    let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(10.0 * Double(NSEC_PER_SEC)))
    dispatch_after(dispatchTime, dispatch_get_main_queue(), {
        GPS()
    })
    
    return returnBool
}


/// BinMan1 : Structor of Setttings table types
struct TypeOfSettings {
    static let LanguageID = "LanguageID"
    static let ServerIP = "ServerIP"
    static let ServerPort = "ServerPort"
    static let CustomerID = "CustomerID"
    static let MobileID = "MobileID"
    static let WiFiSSID = "WiFiSSID"
    static let WiFiMac = "WiFiMac"
    static let CenterIP = "CenterIP"
    static let CenterPort = "CenterPort"
    static let LastMessageID = "LastMessageID"
    static let ExKey = "ExKey"
    static let CustomerName = "CustomerName"
    static let Register = "Register"
    static let Ver = "Ver"
}
