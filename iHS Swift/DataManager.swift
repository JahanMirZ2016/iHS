//
//  DataManager.swift
//  iHS Swift
//
//  Created by arash on 11/19/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import Foundation

/*
 Arash : Class For managing JSON and inserting to database.
 */

class DataManager {
    
    
    /// Arash : func for analyze and parse json for saving in database and later use.
    internal class func JSONAnalyzer(JsonString json: NSString) {
        var jsonDic = NSDictionary()
        do {
            
            jsonDic = try JSONSerializer.toDictionary(json as String)
            sectionJSON(jsonDic["Sections"] as! NSArray)
            roomJSON(jsonDic["Rooms"] as! NSArray)
            nodeJSON(jsonDic["Nodes"] as! NSArray)
            switchJSON(jsonDic["Switches"] as! NSArray)
            scenarioJSON(jsonDic["Scenarios"] as! NSArray)
//            let settingArray = try JSONSerializer.toArray(jsonDic["Setting"] as! String)
            settingJSON(jsonDic["Setting"] as! NSArray)

        } catch let error as NSError {
            Printer("DataManager Parse jsonreceive error : \(error.debugDescription)")
        }
    }
    
    /// Arash : Insert into section table.
    private class func sectionJSON(json : NSArray) {
        for object in json {
            let sectionModel = SectionModel()
            sectionModel.name = (object as! NSDictionary)["Name"] as! String
            sectionModel.id = (object as! NSDictionary)["ID"] as! Int
            sectionModel.sort = (object as! NSDictionary)["Sort"] as! Int
            sectionModel.icon = (object as! NSDictionary)["Icon"] as! String
            DBManager.insertSection(SectionModel: sectionModel)
            
        }
    }
    
    /// Arash : Insert into room table.
    private class func roomJSON(json : NSArray) {
        for object in json {
            let roomModel = RoomModel()
            roomModel.name = (object as! NSDictionary)["Name"] as! String
            roomModel.id = (object as! NSDictionary)["ID"] as! Int
            roomModel.icon = (object as! NSDictionary)["Icon"] as! String
            roomModel.sort = (object as! NSDictionary)["Sort"] as! Int
            roomModel.sectionID = (object as! NSDictionary)["SectionID"] as! Int
            DBManager.insertRoom(RoomModel: roomModel)
        }
    }
    
    /// Arash : Insert into node table.
    private class func nodeJSON(json : NSArray) {
        for object in json {
            let nodeModel = NodeModel()
            nodeModel.name = (object as! NSDictionary)["Name"] as! String
            nodeModel.icon = (object as! NSDictionary)["Icon"] as! String
            nodeModel.id = (object as! NSDictionary)["ID"] as! Int
            nodeModel.isBookmark = (object as! NSDictionary)["IsBookmark"] as! Bool
            nodeModel.nodeType = (object as! NSDictionary)["NodeType"] as! Int
            nodeModel.roomID = (object as! NSDictionary)["RoomID"] as! Int
            nodeModel.status = (object as! NSDictionary)["Status"] as! Int
            DBManager.insertNode(NodeModel: nodeModel)
            
        }
    }
    
    /// Arash : Insert into switch table.
    private class func switchJSON(json : NSArray) {
        for object in json {
            let switchModel = SwitchModel()
            switchModel.id = (object as! NSDictionary)["ID"] as! Int
            switchModel.code = (object as! NSDictionary)["Code"] as! Int
            switchModel.nodeID = (object as! NSDictionary)["NodeID"] as! Int
            switchModel.value = (object as! NSDictionary)["Value"] as! Double
            switchModel.name = (object as! NSDictionary)["Name"] as! String
            DBManager.insertSwitch(SwitchModel: switchModel)
        }
    }
    
    /// Arash : Insert into scenario table.
    private class func  scenarioJSON(json : NSArray) {
        for object in json {
            let scenarioModel = ScenarioModel()
            scenarioModel.active = (object as! NSDictionary)["Active"] as! Int
            scenarioModel.condition = (object as! NSDictionary)["DetailsConditions"] as! String
            scenarioModel.des = (object as! NSDictionary)["Des"] as! String
            scenarioModel.description = (object as! NSDictionary)["DetailsDescription"] as! String
//            scenarioModel.distance = (object as! NSDictionary)["Distance"] as! Double
            scenarioModel.id = (object as! NSDictionary)["ID"] as! Int
            scenarioModel.isStarted = (object as! NSDictionary)["IsStarted"] as! Int
            scenarioModel.result = (object as! NSDictionary)["DetailsResults"] as! String
            DBManager.insertScenario(ScenarioModel: scenarioModel)
        }
    }
    
    
    /// Arash : Insert into setting table.
    private class func settingJSON(json : NSArray) {
        for object in json {
            let LanguageID = (object as! NSDictionary)["LanguageID"] as! String
            let ServerIP = (object as! NSDictionary)["ServerIP"] as! String
            let ServerPort = (object as! NSDictionary)["ServerPort"] as! String
            let CustomerID = (object as! NSDictionary)["CustomerID"] as! String
            let MobileID = (object as! NSDictionary)["MobileID"] as! String
            let WiFiSSID = (object as! NSDictionary)["WiFiSSID"] as! String
            let WiFiMac = (object as! NSDictionary)["WiFiMac"] as! String
            let CenterIP = (object as! NSDictionary)["CenterIP"] as! String
            let CenterPort = (object as! NSDictionary)["CenterPort"] as! String
            let LastMessageID = (object as! NSDictionary)["LastMessageID"] as! String
            let ExKey = (object as! NSDictionary)["ExKey"] as! String
            let CustomerName = (object as! NSDictionary)["CustomerName"] as! String
            let Register = (object as! NSDictionary)["Register"] as! String
            let Ver = (object as! NSDictionary)["Ver"] as! String
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.ServerIP, UpdateValue: ServerIP)
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.ServerPort, UpdateValue: ServerPort)
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.CustomerID, UpdateValue: CustomerID)
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.MobileID, UpdateValue: MobileID)
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.WiFiSSID, UpdateValue: WiFiSSID)
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.WiFiMac, UpdateValue: WiFiMac)
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.CenterIP, UpdateValue: CenterIP)
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.CenterPort, UpdateValue: CenterPort)
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.LastMessageID, UpdateValue: LastMessageID)
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.ExKey, UpdateValue: ExKey)
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.CustomerName, UpdateValue: CustomerName)
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.Register, UpdateValue: Register)
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.Ver, UpdateValue: Ver)
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.LanguageID, UpdateValue: LanguageID)
//            for keyValue in (object as! NSDictionary) {
//                let type = keyValue.key as! String
//                let value = keyValue.value as! String
//                DBManager.updateValuesOfSettingsDB(Type: type, UpdateValue: value)
//            }

        }
        
    }
    
    
}
