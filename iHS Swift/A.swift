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
let NOTIFY_UPDATE_VIEW = "notifyUpdate"

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

/// Arash: Node Type VC (rooms->nodes [rooms] , favorites->nodes [favorites]
enum NodeType {
    case favorites
    case rooms
}

/// Arash: Enum for Switchstates (On and Off)
enum SwitchType {
    case switchh
    case dimmer
    case cooler
    case curtain
    case none
}


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
    Printer("Json Of Sync : \(jsonData.debugDescription)")
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
    
    Printer("Json Of CustomerID \(jsonData.debugDescription)")
    return appDel.socket.send(jsonData)
}

///Arash: Send switch value to center/server
func SendSwitchValue(id : Int , value : Double) {
    let mobileID = DBManager.getValueOfSettingsDB(Type: TypeOfSettings.MobileID)
    var array = [NSDictionary]()
    var array2 = [NSDictionary]()
    let dic2 = ["ID" : String(id) , "Value" : String(value)]
    array2.append(dic2)
    let dic =  ["SwitchStatus" : array2 , "MessageID" : "0" , "RecieverID" : String(mobileID) , "Type" : "SwitchStatus" , "Action" : "Update" , "Date" : "2015-01-01 12:00:00"]
    array.append(dic)
    let json = JsonMaker.arrayToJson(array)
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    if appDel.socket != nil {
        if appDel.socket.state == .connectToLocal || appDel.socket.state == .connectToServer {
            appDel.socket.send(json)
        }
    }
    
}

///Arash: Set Scenario is started and send this informatio to center/server.
func SetScenarioStarted(scenarioModel : ScenarioModel)->Bool {
    let mobileID = DBManager.getValueOfSettingsDB(Type: TypeOfSettings.MobileID)
    var array = [NSDictionary]()
    var array2 = [NSDictionary]()
    let dic2 = ["ID" : String(scenarioModel.id) , "Active" : "2"]
    array2.append(dic2)
    let dic = ["ScenarioStatus" : array2 , "MessageID" : "0" , "RecieverID" : String(mobileID) , "Type" : "ScenarioStatus" , "Action" : "Update" , "Date" : "2015-01-01 12:00:00"]
    array.append(dic)
    let json = JsonMaker.arrayToJson(array)
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    if appDel.socket != nil {
        if appDel.socket.state == .connectToLocal || appDel.socket.state == .connectToServer {
            if appDel.socket.send(json) {
                return true
            }
        }
    }
    
    return false
}

func SetScenarioActive(scenarioModel : ScenarioModel)-> Bool {
    let mobileID = DBManager.getValueOfSettingsDB(Type: TypeOfSettings.MobileID)
    var array = [NSDictionary]()
    var array2 = [NSDictionary]()
    let dic2 = ["ID" : String(scenarioModel.id) , "Active" : String(scenarioModel.active)]
    array2.append(dic2)
    let dic = ["ScenarioStatus" : array2 , "MessageID" : "0" , "RecieverID" : String(mobileID) , "Type" : "ScenarioStatus" , "Action" : "Update" , "Date" : "2015-01-01 12:00:00"]
    array.append(dic)
    let json = JsonMaker.arrayToJson(array)
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    //    if appDel.socket != nil {
    //        if appDel.socket.state == .connectToLocal || appDel.socket.state == .connectToServer {
    if appDel.socket.send(json) {
        return true
        //            }
        //        }
    }
    return false
    
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


/// Arash: Struct of RecieveArray Actions
struct RecieveAction {
    static let Insert = "Insert"
    static let Delete = "Delete"
    static let Update = "Update"
}





