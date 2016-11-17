//
//  A.swift
//  iHS Swift
//
//  Created by Ali Zare Sh on 11/10/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import Foundation
import UIKit


/*
 BinMan1 : This file is for All global variables, functions or structors
 */
let appDel = UIApplication.sharedApplication().delegate as! AppDelegate


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

/// Arash : A function to sync and send data.
func Sync()->Bool {
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    // Arash : Creating SyncDataModel
    let lastMessageID = DBManager.getValueOfSettingsDB(Type: "LastMessageID")!
    let appVerCode = DBManager.getValueOfSettingsDB(Type: "AppVerCode")
    let languageID = DBManager.getValueOfSettingsDB(Type: "LanguageID")
    let mobileID = DBManager.getValueOfSettingsDB(Type: "MobileID")
//    let syncDataModel = SyncDataModel()
//    syncDataModel.LanguageID = DBManager.getValueOfSettingsDB(Type: "LanguageID")!
//    syncDataModel.AppVerCode = DBManager.getValueOfSettingsDB(Type: "AppVerCode")!
//    syncDataModel.LastMessageID = DBManager.getValueOfSettingsDB(Type: "LastMessageID")!
//    
//    // Arash : Creating SyncSendModel
//    let syncSendModel = SyncSendModel()
//    syncSendModel.SyncData = [syncDataModel]
//    syncSendModel.MessageID = "0"
//    syncSendModel.RecieverID = DBManager.getValueOfSettingsDB(Type: "MobileID")!
//    syncSendModel.Type = "SyncData"
//    syncSendModel.Action = ""
//    syncSendModel.Date = "2015-01-01 12:00:00"
    
    var arrayMain = Array<NSDictionary>()
    var array = Array<NSDictionary>()
    
    let dic2:NSDictionary = ["LastMessageID" : lastMessageID , "AppVerCode" : appVerCode! , "LanguageID" : languageID!]
    array.append(dic2)
    
    let dic3:NSDictionary = ["SyncData" : array , "MessageID" : "0" , "RecieverID" : mobileID! , "Type" : "SyncData" , "Action" : "" , "Date" : "2015-01-01 12:00:00"]
    arrayMain.append(dic3)
    
    let jsonData = JsonMaker.arrayToJson(arrayMain)
    if appDel.socket.send(jsonData) {
        return true
    }
    
    return false
}

func sendCustomerId()->Bool {
    let customerID = DBManager.getValueOfSettingsDB(Type: "CustomerID")
    let mobileID = DBManager.getValueOfSettingsDB(Type: "MobileID")
    let exKey = DBManager.getValueOfSettingsDB(Type: "ExKey")
    
    let dic:Dictionary<String , AnyObject> = ["CustomerID" : customerID! , "MobileID" : mobileID! , "ExKey" : exKey!]
    
    let jsonData = JsonMaker.dictionaryToJson(dic)
    Printer(jsonData.debugDescription)
    
    if appDel.socket.send(jsonData) {
        return true
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
