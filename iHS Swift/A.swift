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
import SystemConfiguration.CaptiveNetwork


var timer:NSTimer!

/// Height of Phone screan
let HEIGHTPHONE = UIScreen.mainScreen().bounds.height

/// Width of Phone screan
let WIDTHPHONE = UIScreen.mainScreen().bounds.width

/// BinMan1 : Notifcation names for update views
let SCENARIO_UPDATE_VIEW = "scenarioUpdateView"
let ROOM_UPDATE_VIEW = "roomUpdateView"
let NODE_UPDATE_VIEW = "nodeUpdateView"
let SECTION_UPDATE_VIEW = "sectionUpdateView"
let SWITCH_UPDATE_VIEW = "switchUpdateView"
let ACTIONBAR_UPDATE_VIEW = "notifyUpdateView"

/// Arash : Struct for control the state of actionbar View
struct ActionBarState {
    static let notify = "notify"
    static let noInternetConnection = "noInternetConnection"
    static let localConnection = "localConnection"
    static let globalConnection = "globalConnection"
}

///// BinMan1 : enumaration for control the state of actionbar View
//enum ActionBarState {
//    case notify
//    case noInternetConnection
//    case localConnection
//    case globalConnection
//}

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
    let lastMessageID = DBManager.getValueOfSettingsDB(Type: TypeOfSettings.LastMessageID)
    let appVerCode = DBManager.getValueOfSettingsDB(Type: TypeOfSettings.Ver)
    let languageID = DBManager.getValueOfSettingsDB(Type: TypeOfSettings.LanguageID)
    let mobileID = DBManager.getValueOfSettingsDB(Type: TypeOfSettings.MobileID)
    
    var arrayMain = Array<NSDictionary>()
    var array = Array<NSDictionary>()
    
    let dic2:NSDictionary = ["LastMessageID" : lastMessageID! , "AppVerCode" : appVerCode! , "LanguageID" : languageID!]
    array.append(dic2)
    
    let dic3:NSDictionary = ["SyncData" : array , "MessageID" : "0" , "RecieverID" : mobileID! , "Type" : "SyncData" , "Action" : "Update" , "Date" : "2015-01-01 12:00:00"]
    arrayMain.append(dic3)
    
    let jsonData = JsonMaker.arrayToJson(arrayMain)
    Printer("Sync : \(jsonData.debugDescription)")
    return appDel.socket.send(jsonData)
}

/// Arash: Send customer id.
func SendCustomerId() -> Bool {
    let customerID = DBManager.getValueOfSettingsDB(Type: TypeOfSettings.CustomerID)
    let mobileID = DBManager.getValueOfSettingsDB(Type: TypeOfSettings.MobileID)
    let exKey = DBManager.getValueOfSettingsDB(Type: TypeOfSettings.ExKey)
    let dic:Dictionary<String , AnyObject> = ["CustomerID" : customerID! , "MobileID" : mobileID! , "ExKey" : exKey!]
    
    var array = [Dictionary<String , AnyObject>]()
    array = [dic]
    
    let jsonData = JsonMaker.arrayToJson(array)
    
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    
    return appDel.socket.send(jsonData)
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

struct RecieveType {
    static let ScenarioStatus = "ScenarioStatus"
    static let Setting = "Setting"
    static let SwitchStatus = "SwitchStatus"
    static let SwitchData = "SwitchData"
    static let ScenarioData = "ScenarioData"
    static let NodeData = "NodeData"
    static let SectionData = "SectionData"
    static let RoomData = "RoomData"
    static let Notify = "Notify"
    static let SyncData = "SyncData"
    static let RefreshData = "RefreshData"
    
}

/// Arash: Enum of RecieveArray Types
//    enum RecieveType:CustomStringConvertible {
//        case ScenarioStatus
//        case Setting
//        case SwitchStatus
//        case SwitchData
//        case ScenarioData
//        case NodeData
//        case SectionData
//        case RoomData
//        case Notify
//        case SyncData
//        case RefreshData
//
//        var description : String {
//            switch self {
//            // Use Internationalization, as appropriate.
//            case .ScenarioStatus: return "Bing";
//            case .Setting: return "Setting";
//            case .SwitchStatus: return "SwitchStatus";
//            case .SwitchData: return "SwitchData";
//            case .ScenarioData: return "ScenarioData";
//            case .NodeData: return "NodeData";
//            case .SectionData: return "SectionData";
//            case .RoomData: return "RoomData";
//            case .Notify: return "Notify";
//            case .SyncData: return "SyncData";
//            case .RefreshData: return "RefreshData";
//
//            }
//        }
//    }

/// Arash: Enum of RecieveArray Actions
struct RecieveAction {
    static let Insert = "Insert"
    static let Delete = "Delete"
    static let Update = "Update"
}

//extension UIDevice {
//    public var SSID: String {
//        get {
//            let interfaces:CFArray! = CNCopySupportedInterfaces()
//            for i in 0..<CFArrayGetCount(interfaces){
//                let interfaceName: UnsafePointer<Void>
//                    =  CFArrayGetValueAtIndex(interfaces, i)
//                let rec = unsafeBitCast(interfaceName, AnyObject.self)
//                let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)")
//                if unsafeInterfaceData != nil {
//                    let interfaceData = unsafeInterfaceData! as NSDictionary
//                    let currentSSID = interfaceData["SSID"] as! String
//
//            }
//        }
//    }
//}


