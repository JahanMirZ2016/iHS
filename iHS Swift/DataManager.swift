//
//  DataManager.swift
//  iHS Swift
//
//  Created by arash on 11/19/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import Foundation
import UIKit

/*
 Arash : Class For managing JSON and inserting to database.
 */

class DataManager {
    
    
    /// Arash : func for analyze and parse jsonObject for saving in database and later use.
    private class func JSONObjectAnalyzer(JsonDic jsonDic: NSDictionary) {
        
        
        sectionJSON(jsonDic["Sections"] as! NSArray)
        roomJSON(jsonDic["Rooms"] as! NSArray)
        nodeJSON(jsonDic["Nodes"] as! NSArray)
        switchJSON(jsonDic["Switches"] as! NSArray)
        scenarioJSON(jsonDic["Scenarios"] as! NSArray)
        settingJSON(jsonDic["Setting"] as! NSArray)
        
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.Register, UpdateValue: "1")
        
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if appDel.socket.close() {
            appDel.socket = SocketManager()
            appDel.startCheckingInternet()
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
//            nodeModel.isBookmark = (object as! NSDictionary)["IsBookmark"] as! Bool
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
            switchModel.code = Int((object as! NSDictionary)["Code"] as! String)!
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
            
            //            let LanguageID = (object as! NSDictionary)["LanguageID"] as! String
            let ServerIP = (object as! NSDictionary)["ServerIP"] as! String
            let ServerPort = (object as! NSDictionary)["ServerPort"] as! Int
            let CustomerID = (object as! NSDictionary)["CustomerID"] as! Int
            let MobileID = (object as! NSDictionary)["MobileID"] as! Int
            let WiFiSSID = (object as! NSDictionary)["WiFiSSID"] as! String
            let WiFiMac = (object as! NSDictionary)["WiFiMac"] as! String
            let CenterIP = (object as! NSDictionary)["CenterIP"] as! String
            let CenterPort = (object as! NSDictionary)["CenterPort"] as! Int
            let LastMessageID = (object as! NSDictionary)["LastMessageID"] as! Int
            let ExKey = (object as! NSDictionary)["ExKey"] as! String
            let CustomerName = (object as! NSDictionary)["CustomerName"] as! String
            //            let Register = (object as! NSDictionary)["Register"] as! String
            let Ver = (object as! NSDictionary)["Ver"] as! String
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.ServerIP, UpdateValue: ServerIP)
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.ServerPort, UpdateValue: String(ServerPort))
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.CustomerID, UpdateValue: String(CustomerID))
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.MobileID, UpdateValue: String(MobileID))
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.WiFiSSID, UpdateValue: WiFiSSID)
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.WiFiMac, UpdateValue: WiFiMac)
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.CenterIP, UpdateValue: CenterIP)
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.CenterPort, UpdateValue: String(CenterPort))
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.LastMessageID, UpdateValue: String(LastMessageID))
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.ExKey, UpdateValue: ExKey)
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.CustomerName, UpdateValue: CustomerName)
            //            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.Register, UpdateValue: Register)
            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.Ver, UpdateValue: Ver)
            //            DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.LanguageID, UpdateValue: LanguageID)
            //            for keyValue in (object as! NSDictionary) {
            //                let type = keyValue.key as! String
            //                let value = keyValue.value as! String
            //                DBManager.updateValuesOfSettingsDB(Type: type, UpdateValue: value)
            //            }
            
        }
        
    }
    
    /// Arash : func for analyze and parse jsonArray for saving in database and later use.
    private class func JSONArrayAnalyzer(jsonArray:Array<NSDictionary>) {
        
        for object in jsonArray {
            
            //            let messageID = String(object["MessageID"] as! Int)
            let type = object["Type"] as! String
            let action = object["Action"] as! String
            switch type {
            ///RecieveType.ScenarioData
            case RecieveType.ScenarioData:
                
                let scenarioArray = object["ScenarioData"] as! Array<NSDictionary>
                for dic in scenarioArray {
                    
                    //                syncRecieveModel.RecieverIDs = object["RecieverID"] as! NSDictionary
                    let scenario = ScenarioModel()
                    scenario.active = dic["Active"] as! Int
                    scenario.condition = dic["DetailsConditions"] as!  String
                    scenario.description = dic["DetailsDescription"] as! String
                    scenario.des = dic["Des"] as! String
                    scenario.id = dic["ID"] as! Int
                    scenario.name = dic["Name"] as! String
                    scenario.result = dic["DetailsResults"] as! String
                    switch action {
                    case RecieveAction.Insert:
                        DBManager.insertScenario(ScenarioModel: scenario); break
                    case RecieveAction.Delete:
                        DBManager.deleteScenario(ScnarioID: scenario.id); break
                    case RecieveAction.Update:
                        DBManager.updateScenario(scenario)
                        break
                    default: break
                    }
                    
                    NSNotificationCenter.defaultCenter().postNotificationName(SCENARIO_UPDATE_VIEW, object: nil)
                }
                break
            /// RecieveType.SwitchStatus
            case RecieveType.SwitchStatus:
                let switchStatusArray = object["SwitchStatus"] as! Array<NSDictionary>
                for dic in switchStatusArray {
                    //                    let switchStatus = object["SwitchStatus"] as! NSDictionary
                    let id = dic["ID"] as! Int
                    let value = dic["Value"] as! Float
                    DBManager.updateSwitchStatus(id, value: value)
                    //
                    
                    NSNotificationCenter.defaultCenter().postNotificationName(SWITCH_UPDATE_VIEW, object: nil)
                }
                break
            /// RecieveType.ScenarioStatus
            case RecieveType.ScenarioStatus:
                let scenarioStatusArray = object["ScenarioStatus"] as! Array<NSDictionary>
                for dic in scenarioStatusArray {
                    //                    let switchStatus = object["SwitchStatus"] as! NSDictionary
                    let id = dic["ID"] as! Int
                    let active = dic["Active"] as! Int
                    if active < 2 {
                        DBManager.activeScenario(id, active: active)
                    }else {
                        DBManager.startScenario(id, active: active)
                    }
                    
                    NSNotificationCenter.defaultCenter().postNotificationName(SCENARIO_UPDATE_VIEW, object: nil)
                }
                break
            /// RecieveType.Setting
            case RecieveType.Setting :
                let settingArray = object["Setting"] as! Array<NSDictionary>
                for dic in settingArray {
                    DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.ServerIP , UpdateValue: dic["ServerIP"] as! String)
                    DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.ServerPort, UpdateValue: dic["ServerPort"] as! String)
                    DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.CenterIP, UpdateValue: dic["CenterIP"] as! String)
                    DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.CenterPort, UpdateValue: dic["CenterPort"] as! String)
                    DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.WiFiSSID, UpdateValue: dic["WiFiSSID"] as! String)
                    DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.WiFiMac, UpdateValue: dic["WiFiMac"] as! String)
                }
                break
            ///RecieveType.SwitchData
            case RecieveType.SwitchData :
                let switchDataArray = object["SwitchData"] as! Array<NSDictionary>
                for dic in switchDataArray {
                    let switchModel = SwitchModel()
                    switchModel.code = dic["Code"] as! Int
                    switchModel.id = dic["ID"] as! Int
                    switchModel.name = dic["Name"] as! String
                    switchModel.nodeID = dic["NodeID"] as! Int
                    switchModel.value = dic["Value"] as! Double //
                    if action == RecieveAction.Insert {
                        DBManager.insertSwitch(SwitchModel: switchModel)
                    }else if action == RecieveAction.Delete {
                        DBManager.deleteSwitch(SwitchID: switchModel.id)
                    }else if action == RecieveAction.Update {
                        DBManager.updateSwitch(switchModel)
                    }
                    
                    NSNotificationCenter.defaultCenter().postNotificationName(SWITCH_UPDATE_VIEW, object: nil)
                }
                break
            ///RecieveType.SwitchData
            case RecieveType.NodeData :
                let nodeDataArray = object["NodeData"] as! Array<NSDictionary>
                for dic in nodeDataArray {
                    let nodeModel = NodeModel()
                    nodeModel.id = dic["ID"] as! Int
                    nodeModel.name = dic["Name"] as! String
                    nodeModel.nodeType = dic["NodeTypeID"] as! Int
                    nodeModel.status = dic["Status"] as! Int
                    nodeModel.roomID = dic["RoomID"] as! Int
                    nodeModel.icon = "Node" + (dic["Icon"] as! String)
                    if action == RecieveAction.Insert {
                        DBManager.insertNode(NodeModel: nodeModel)
                    }  else if action == RecieveAction.Delete {
                        DBManager.deleteNode(NodeID: nodeModel.id)
                    }  else if action == RecieveAction.Update {
                        DBManager.updateNode(nodeModel)
                    }
                    
                    NSNotificationCenter.defaultCenter().postNotificationName(NODE_UPDATE_VIEW, object: nil)
                }
                break
            ///RecieveType.SectionData
            case RecieveType.SectionData :
                let sectionDataArray = object["SectionData"] as! Array<NSDictionary>
                for dic in sectionDataArray {
                    let sectionModel = SectionModel()
                    sectionModel.id = dic["ID"] as! Int
                    sectionModel.name = dic["Name"] as! String
                    sectionModel.sort = dic["Sort"] as! Int
                    sectionModel.icon = "Section" + (dic["Icon"] as! String)
                    if action == RecieveAction.Insert {
                        DBManager.insertSection(SectionModel: sectionModel)
                    }else if action == RecieveAction.Delete {
                        DBManager.deleteSection(sectionModel.id)
                    }else if action == RecieveAction.Update {
                        DBManager.updateSection(sectionModel)
                    }
                    NSNotificationCenter.defaultCenter().postNotificationName(SECTION_UPDATE_VIEW, object: nil)
                }
                break
            ///RecieveType.RoomData
            case RecieveType.RoomData :
                let roomDataArray = object["RoomData"] as! Array<NSDictionary>
                for dic in roomDataArray {
                    let roomModel = RoomModel()
                    roomModel.id = dic["ID"] as! Int
                    roomModel.name = dic["Name"] as! String
                    roomModel.icon = "Section" + (dic["Icon"] as! String)
                    roomModel.sort = dic["Sort"] as! Int
                    roomModel.sectionID = dic["SectionID"] as! Int
                    if action == RecieveAction.Insert {
                        DBManager.insertRoom(RoomModel: roomModel)
                    }else if action == RecieveAction.Delete {
                        DBManager.deleteRoom(RoomID: roomModel.id)
                    }else if action == RecieveAction.Update {
                        DBManager.updateRoom(roomModel)
                    }
                    NSNotificationCenter.defaultCenter().postNotificationName(ROOM_UPDATE_VIEW, object: nil)
                }
                break
            ///RecieveType.Notify
            case RecieveType.Notify :
                let notifyArray = object["Notify"] as! Array<NSDictionary>
                for dic in notifyArray {
                    let notifyModel = NotifyModel()
                    notifyModel.notifyTitle = dic["NotifyTitle"] as! String
                    notifyModel.notifyText = dic["NotifyText"] as! String
                    notifyModel.seen = false
                    DBManager.insertNotify(NotifyModel: notifyModel)
                    /// master.setNotify
                    
                    /// callNotification
                    
                    NSNotificationCenter.defaultCenter().postNotificationName(ACTIONBAR_UPDATE_VIEW, object: ActionBarState.notify as AnyObject)
                }
                break
            ///RecieveType.SyncData
            case RecieveType.SyncData where action == RecieveAction.Delete :
                DBManager.resetFactory()
                break
            ///RecieveType.SyncData
            case RecieveType.RefreshData :
                let refreshDataArray = object["Notify"] as! Array<Dictionary<String , AnyObject>>
                let dic = refreshDataArray[0]
                let str:NSString = JsonMaker.dictionaryToJson(dic)
                JSONAnalyzer(str)
                DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.Register, UpdateValue: "1")
                break
                
            default:
                break
            }
        }
    }
    
    class func JSONAnalyzer(json:NSString ) {
        
        if json.substringWithRange(NSRange(location: 0, length: 1)) == "[" {
            do {
                let jsonArray =  try JSONSerializer.toArray(json as String)
                JSONArrayAnalyzer(jsonArray as! Array<NSDictionary>)
            } catch let error as NSError {
                Printer("Json Array Failed : \(error.debugDescription)")
            }
            
        } else if json.substringWithRange(NSRange(location: 0, length: 1)) == "{" {
            do {
                let jsonObject = try JSONSerializer.toDictionary(json as String)
                JSONObjectAnalyzer(JsonDic: jsonObject)
            } catch let e as NSError {
                Printer("Json Object Failed : \(e.debugDescription)")
            }
        }
    }
}



