//
//  DBManager.swift
//  iHS Swift
//
//  Created by Ali Zare Sh on 11/10/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import Foundation



/*
 BinMan1 : Class For managing the DataBase
 */
class DBManager {
    /// BinMan1 : Get Some Translation of Sentense
    class func getTranslationOfSentences(SentencesID ids : [Int]) -> Array<String> {
        let db = GetDBFromPath()
        db!.open()
        do {
            var resultStringArray = Array<String>()
            for id in ids {
                let result = try db!.executeQuery("SELECT * FROM Translation WHERE LangID = \(SELECTEDLANGID) AND SentenseID = \(id)", values: nil)
                if result.next() {
                    resultStringArray.append(result.stringForColumn("SentenseText"))
                }
            }
            
            db!.close()
            return resultStringArray
        } catch let error as NSError{
            Printer("DBManger Get Translation Error : \(error.debugDescription)")
            db!.close()
            return Array<String>()
        }
    }
    
    
    
    /// BinMan1 : Get specific value of Settings types
    class func getValueOfSettingsDB (Type type : String ) -> String? {
        let db = GetDBFromPath()
        db!.open()
        do {
            var resultString = String()
            let query = "SELECT * FROM Settings WHERE type = ?"
            let result = try db!.executeQuery(query, values: [type])
            if result.next() {
                resultString = result.stringForColumn("value")
            }
            db!.close()
            return resultString
        } catch let err as NSError {
            Printer("DBManger Getting settings error : \(err.debugDescription)")
            db!.close()
            return nil
        }
        
    }
    
    /// BinMan1 : Update value of types in Setting DB
    class func updateValuesOfSettingsDB (Type type : String , UpdateValue value : String) -> Bool {
        let db = GetDBFromPath()
        db!.open()
        do {
            let query = "UPDATE Settings SET value = ? WHERE type = ?"
            try db!.executeUpdate(query, values: [value , type])
            db!.close()
            return true
        } catch let err as NSError {
            Printer("DBManger update settings error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    
    
    /// BinMan1 : Inser A node to DB
    class func insertNode(NodeModel node : NodeModel) -> Bool {
        let db = GetDBFromPath()
        db!.open()
        do {
            let query = "INSERT INTO Node (ID, Name , Icon , NodeType,IsBookMark, RoomID , Status) VALUES (?, ? , ? , ? , ? , ? , ?)"
            try db!.executeUpdate(query, values: [node.id , node.name , node.icon , node.nodeType , node.isBookmark , node.roomID, node.status])
            db!.close()
            return true
        }catch let err as NSError {
            Printer("DBManager insert node error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    
    /// BinMan1 : Get a specific object of nodes from table
    class func getNode(NodeID id : Int) -> NodeModel? {
        let db = GetDBFromPath()
        db!.open()
        do {
            let query = "SELECT * FROM Node WHERE ID = ?"
            let result = try db!.executeQuery(query, values: [id])
            let model = NodeModel()
            if result.next() {
                model.id = Int(result.intForColumn("ID"))
                model.name = result.stringForColumn("Name")
                model.icon = result.stringForColumn("Icon")
                model.nodeType = Int(result.intForColumn("NodeType"))
                model.isBookmark = result.boolForColumn("IsBookmark")
                model.roomID = Int(result.intForColumn("RoomID"))
                model.status = Int(result.intForColumn("Status"))
            }
            db!.close()
            return model
        }catch let err as NSError {
            Printer("DBManager get specific node error : \(err.debugDescription)")
            db!.close()
            return nil
        }
    }
    
    /// BinMan1 : Get All Nodes From Node table
    class func getAllNodes() -> [NodeModel]? {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "SELECT * FROM Node"
            let result = try db!.executeQuery(query, values: nil)
            var models = [NodeModel]()
            while result.next() {
                let model = NodeModel()
                model.id = Int(result.intForColumn("ID"))
                model.name = result.stringForColumn("Name")
                model.icon = result.stringForColumn("Icon")
                model.nodeType = Int(result.intForColumn("NodeType"))
                model.isBookmark = result.boolForColumn("IsBookmark")
                model.roomID = Int(result.intForColumn("RoomID"))
                model.status = Int(result.intForColumn("Status"))
                models.append(model)
            }
            db!.close()
            return models
        } catch let err as NSError {
            Printer("DBManager get All nodes error : \(err.debugDescription)")
            db!.close()
            return nil
        }
    }
    
    /// BinMan1 : Get All Favorite Nodes From Node table
    class func getAllFavorites() -> [NodeModel]? {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "SELECT * FROM Node WHERE IsBookmark = ?"
            let result = try db!.executeQuery(query, values: [1])
            var models = [NodeModel]()
            while result.next() {
                let model = NodeModel()
                model.id = Int(result.intForColumn("ID"))
                model.name = result.stringForColumn("Name")
                model.icon = result.stringForColumn("Icon")
                model.nodeType = Int(result.intForColumn("NodeType"))
                model.isBookmark = result.boolForColumn("IsBookmark")
                model.roomID = Int(result.intForColumn("RoomID"))
                model.status = Int(result.intForColumn("Status"))
                models.append(model)
            }
            db!.close()
            return models
        } catch let err as NSError {
            Printer("DBManager get All nodes error : \(err.debugDescription)")
            db!.close()
            return nil
        }
    }
    
    /// BinMan1 : Delete specific record from Node table
    class func deleteNode(NodeID  id : Int) -> Bool {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "DELETE FROM Node WHERE ID = ?"
            try db!.executeUpdate(query, values: [id])
            db!.close()
            return true
        } catch let err as NSError {
            Printer("DBManager get All nodes error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    
    
    /// BinMan1 : Delete All Nodes from Node table
    class func deleteAllNodes () -> Bool {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "DELETE FROM Node"
            try db!.executeUpdate(query, values: nil)
            db!.close()
            return true
        } catch let err as NSError {
            Printer("DBManager get All nodes error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    
    
    /// BinMan1 : Insert Notify to table
    class func insertNotify(NotifyModel notify : NotifyModel) -> Bool {
        let db = GetDBFromPath()
        db!.open()
        do {
            let query = "INSERT INTO Notify (ID, NotifyTitle , NotifyText ,Seen) VALUES (?, ? , ? , ? )"
            try db!.executeUpdate(query, values: [notify.id , notify.notifyTitle , notify.notifyText , notify.seen])
            db!.close()
            return true
        }catch let err as NSError {
            Printer("DBManager insert node error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    
    /// BinMan1 : Get a notify object of nodes from table
    class func getNotify(NodeID id : Int) -> NotifyModel? {
        let db = GetDBFromPath()
        db!.open()
        do {
            let query = "SELECT * FROM Notify WHERE ID = ?"
            let result = try db!.executeQuery(query, values: [id])
            let model = NotifyModel()
            if result.next() {
                model.id = Int(result.intForColumn("ID"))
                model.notifyTitle = result.stringForColumn("NotifyTitle")
                model.notifyText = result.stringForColumn("NotifyText")
                model.seen = result.boolForColumn("Seen")
            }
            db!.close()
            return model
        }catch let err as NSError {
            Printer("DBManager get specific node error : \(err.debugDescription)")
            db!.close()
            return nil
        }
    }
    
    ///Arash: Get last 10 notifies.
    class func getLastNotifies()->[NotifyModel]? {
        let db = GetDBFromPath()
        db!.open()
        defer {db?.close()}
        do {
            let query = "SELECT NotifyTitle,NotifyText FROM Notify ORDER BY ID DESC LIMIT 0,10"
            let result = try db!.executeQuery(query, values: nil)
            var models = [NotifyModel]()
            while result.next() {
                let model = NotifyModel()
                model.id = Int(result.intForColumn("ID"))
                model.notifyText = result.stringForColumn("NotifyText")
                model.notifyTitle = result.stringForColumn("NotifyTitle")
                model.seen = result.boolForColumn("Seen")
                updateLastNotifies(notifyID: model.id)
                
                models.append(model)
            }
            return models
        } catch let err as NSError {
            Printer("DBManager getLastNotifies error : \(err.debugDescription)")
            return nil
        }
    }
    
    ///Arash: Update last seen notifies.(mark notify as seen.)
    class func updateLastNotifies(notifyID id : Int) {
        let db = GetDBFromPath()
        
        do {
            let query = "UPDATE Notify SET Seen = ? WHERE ID = ?"
            try db!.executeUpdate(query, values: [1 , id])
        } catch let err as NSError {
            Printer("DBManger updateLastNotifies error : \(err.debugDescription)")
        }
    }
    
    /// BinMan1 : Get All Nodes From Node table
    class func getAllNotifies() -> [NotifyModel]? {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "SELECT * FROM Notify"
            let result = try db!.executeQuery(query, values: nil)
            var models = [NotifyModel]()
            while result.next() {
                let model = NotifyModel()
                model.id = Int(result.intForColumn("ID"))
                model.notifyTitle = result.stringForColumn("NotifyTitle")
                model.notifyText = result.stringForColumn("NotifyText")
                model.seen = result.boolForColumn("Seen")
                models.append(model)
            }
            db!.close()
            return models
        } catch let err as NSError {
            Printer("DBManager get All nodes error : \(err.debugDescription)")
            db!.close()
            return nil
        }
    }
    
    /// BinMan1 : Get All Notifies that not seen From Node table
    class func getAllNotSeenNotifies() -> [NotifyModel]? {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "SELECT * FROM Notify WHERE Seen = ?"
            let result = try db!.executeQuery(query, values: [0])
            var models = [NotifyModel]()
            while result.next() {
                let model = NotifyModel()
                model.id = Int(result.intForColumn("ID"))
                model.notifyTitle = result.stringForColumn("NotifyTitle")
                model.notifyText = result.stringForColumn("NotifyText")
                model.seen = result.boolForColumn("Seen")
                models.append(model)
            }
            db!.close()
            return models
        } catch let err as NSError {
            Printer("DBManager get All nodes error : \(err.debugDescription)")
            db!.close()
            return nil
        }
    }
    
    /// BinMan1 : Delete specific record from Notify table
    class func deleteNotify(NotifyID  id : Int) -> Bool {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "DELETE FROM Notify WHERE ID = ?"
            try db!.executeUpdate(query, values: [id])
            db!.close()
            return true
        } catch let err as NSError {
            Printer("DBManager get All nodes error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    
    
    /// BinMan1 : Delete All Notifies from Notify table
    class func deleteAllNotifies () -> Bool {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "DELETE FROM Notify"
            try db!.executeUpdate(query, values: nil)
            db!.close()
            return true
        } catch let err as NSError {
            Printer("DBManager get All nodes error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    
    /// BinMan1 : Insert Scenario to table
    class func insertScenario(ScenarioModel scenario : ScenarioModel) -> Bool {
        var duplicate = false
        let scenarioModels = getAllScenarios()
        for model in scenarioModels! {
            if model.id == scenario.id {
                duplicate = true
            }
        }
        guard duplicate == false else {
            return false
        }
        
        let db = GetDBFromPath()
        db!.open()
        do {
            let query = "INSERT INTO Scenario (ID, Name , Active , IsStarted ,Lat ,Long, Distance , Description ,Result,Condition, Des ) VALUES (?, ? , ? , ?, ?, ? , ? , ?, ?, ? , ?)"
            try db!.executeUpdate(query, values: [scenario.id , scenario.name , scenario.active , scenario.isStarted , scenario.lat , scenario.long , scenario.distance , scenario.description , scenario.result , scenario.condition , scenario.des])
            db!.close()
            return true
        }catch let err as NSError {
            Printer("DBManager insert node error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    
    /// BinMan1 : Get a Scenario object of Scenarios from table
    class func getScenario(ScenarioID id : Int) -> ScenarioModel? {
        let db = GetDBFromPath()
        db!.open()
        do {
            let query = "SELECT * FROM Scenario WHERE ID = ?"
            let result = try db!.executeQuery(query, values: [id])
            let model = ScenarioModel()
            if result.next() {
                model.id = Int(result.intForColumn("ID"))
                model.name = result.stringForColumn("Name")
                model.active = Int(result.intForColumn("Active"))
                model.isStarted = Int(result.intForColumn("IsStarted"))
                model.lat = result.doubleForColumn("Lat")
                model.long = result.doubleForColumn("Long")
                model.distance = result.doubleForColumn("Distance")
                model.description = result.stringForColumn("Description")
                model.result = result.stringForColumn("Result")
                model.condition = result.stringForColumn("Condition")
                model.des = result.stringForColumn("Des")
            }
            db!.close()
            return model
        }catch let err as NSError {
            Printer("DBManager get specific node error : \(err.debugDescription)")
            db!.close()
            return nil
        }
    }
    
    
    /// BinMan1 : Get All Scenarios From Scenario table
    class func getAllScenarios() -> [ScenarioModel]? {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "SELECT * FROM Scenario"
            let result = try db!.executeQuery(query, values: nil)
            var models = [ScenarioModel]()
            while result.next() {
                let model = ScenarioModel()
                model.id = Int(result.intForColumn("ID"))
                model.name = result.stringForColumn("Name")
                model.active = Int(result.intForColumn("Active"))
                model.isStarted = Int(result.intForColumn("IsStarted"))
                model.lat = result.doubleForColumn("Lat")
                model.long = result.doubleForColumn("Long")
                model.distance = result.doubleForColumn("Distance")
                model.description = result.stringForColumn("Description")
                model.result = result.stringForColumn("Result")
                model.condition = result.stringForColumn("Condition")
                model.des = result.stringForColumn("Des")
                models.append(model)
            }
            db!.close()
            return models
        } catch let err as NSError {
            Printer("DBManager get All nodes error : \(err.debugDescription)")
            db!.close()
            return nil
        }
    }
    
    
    /// BinMan1 : Delete specific record from Scenario table
    class func deleteScenario(ScnarioID  id : Int) -> Bool {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "DELETE FROM Scenario WHERE ID = ?"
            try db!.executeUpdate(query, values: [id])
            db!.close()
            return true
        } catch let err as NSError {
            Printer("DBManager get All Scenarios error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    
    
    /// BinMan1 : Delete All Notifies from Notify table
    class func deleteAllScenarios () -> Bool {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "DELETE FROM Scenario"
            try db!.executeUpdate(query, values: nil)
            db!.close()
            return true
        } catch let err as NSError {
            Printer("DBManager get All Scenarios error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    
    
    
    /// BinMan1 : Insert Switch to table
    class func insertSwitch(SwitchModel switchModel : SwitchModel) -> Bool {
        let db = GetDBFromPath()
        db!.open()
        do {
            let query = "INSERT INTO Switch (ID, Code , Name , Value ,NodeID) VALUES (?, ? , ? , ?, ?)"
            try db!.executeUpdate(query, values: [switchModel.id , switchModel.code , switchModel.name , switchModel.value , switchModel.nodeID ])
            db!.close()
            return true
        }catch let err as NSError {
            Printer("DBManager insert switch error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    
    /// BinMan1 : Get a Scenario object of Scenarios from table
    class func getSwitch(SwitchID id : Int) -> SwitchModel? {
        let db = GetDBFromPath()
        db!.open()
        do {
            let query = "SELECT * FROM Switch WHERE NodeID = ?"
            let result = try db!.executeQuery(query, values: [id])
            let model = SwitchModel()
            if result.next() {
                model.id = Int(result.intForColumn("ID"))
                model.code = Int(result.intForColumn("Code"))
                model.name = result.stringForColumn("Name")
                model.value = result.doubleForColumn("Value")
                model.nodeID = Int(result.intForColumn("NodeID"))
            }
            db!.close()
            return model
        }catch let err as NSError {
            Printer("DBManager get specific switch error : \(err.debugDescription)")
            db!.close()
            return nil
        }
    }
    
    
    /// BinMan1 : Get All Scenarios From Scenario table
    class func getAllSwitches() -> [SwitchModel]? {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "SELECT * FROM Switch"
            let result = try db!.executeQuery(query, values: nil)
            var models = [SwitchModel]()
            while result.next() {
                let model = SwitchModel()
                model.id = Int(result.intForColumn("ID"))
                model.name = result.stringForColumn("Name")
                model.code = Int(result.intForColumn("Code"))
                model.value = result.doubleForColumn("Value")
                model.nodeID = Int(result.intForColumn("NodeID"))
                models.append(model)
            }
            db!.close()
            return models
        } catch let err as NSError {
            Printer("DBManager get All Switches error : \(err.debugDescription)")
            db!.close()
            return nil
        }
    }
    
    
    /// BinMan1 : Delete specific record from Scenario table
    class func deleteSwitch(SwitchID  id : Int) -> Bool {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "DELETE FROM Switch WHERE ID = ?"
            try db!.executeUpdate(query, values: [id])
            db!.close()
            return true
        } catch let err as NSError {
            Printer("DBManager get All Switch error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    
    
    /// BinMan1 : Delete All Notifies from Notify table
    class func deleteAllSwitches () -> Bool {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "DELETE FROM Switch"
            try db!.executeUpdate(query, values: nil)
            db!.close()
            return true
        } catch let err as NSError {
            Printer("DBManager get All Switches error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    
    /// BinMan1 : Insert Switch to table
    class func insertSection(SectionModel section : SectionModel) -> Bool {
        var duplicate = false
        let sectionModels = getAllSections()
        for model in sectionModels! {
            if model.id == section.id {
                duplicate = true
            }
        }
        guard duplicate == false else {
            return false
        }
        let db = GetDBFromPath()
        db!.open()
        do {
            let query = "INSERT INTO Section (ID, Name , Icon , Sort ) VALUES (? , ? , ?, ?)"
            try db!.executeUpdate(query, values: [section.id , section.name , section.icon , section.sort])
            db!.close()
            return true
        }catch let err as NSError {
            Printer("DBManager insert switch error : \(err.debugDescription)")
            db!.close()
            return false
        }
        
    }
    
    /// BinMan1 : Get a Section object of Sections from table
    class func getSection(SwitchID id : Int) -> SectionModel? {
        let db = GetDBFromPath()
        db!.open()
        do {
            let query = "SELECT * FROM Section WHERE ID = ?"
            let result = try db!.executeQuery(query, values: [id])
            let model = SectionModel()
            if result.next() {
                model.id = Int(result.intForColumn("ID"))
                model.icon = result.stringForColumn("Icon")
                model.name = result.stringForColumn("Name")
                model.sort = Int(result.intForColumn("Sort"))
            }
            db!.close()
            return model
        }catch let err as NSError {
            Printer("DBManager get specific Section error : \(err.debugDescription)")
            db!.close()
            return nil
        }
    }
    
    
    /// BinMan1 : Get All Sections From Section table
    class func getAllSections() -> [SectionModel]? {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "SELECT * FROM Section"
            let result = try db!.executeQuery(query, values: nil)
            var models = [SectionModel]()
            while result.next() {
                let model = SectionModel()
                model.id = Int(result.intForColumn("ID"))
                model.name = result.stringForColumn("Name")
                model.icon = result.stringForColumn("Icon")
                model.sort = Int(result.intForColumn("Sort"))
                models.append(model)
            }
            db!.close()
            return models
        } catch let err as NSError {
            Printer("DBManager get All Section error : \(err.debugDescription)")
            db!.close()
            return nil
        }
    }
    
    
    /// BinMan1 : Delete Section record from Section table
    class func deleteSwitch(SectionID  id : Int) -> Bool {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "DELETE FROM Section WHERE ID = ?"
            try db!.executeUpdate(query, values: [id])
            db!.close()
            return true
        } catch let err as NSError {
            Printer("DBManager get All Section error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    
    
    /// BinMan1 : Delete All Sections from Notify table
    class func deleteAllSections () -> Bool {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "DELETE FROM Section"
            try db!.executeUpdate(query, values: nil)
            db!.close()
            return true
        } catch let err as NSError {
            Printer("DBManager get All Sections error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    
    
    /// BinMan1 : Insert Room to table
    class func insertRoom(RoomModel room : RoomModel) -> Bool {
        var duplicate = false
        let roomModels = getAllRooms()
        for model in roomModels! {
            if model.id == room.id {
                duplicate = true
            }
        }
        guard duplicate == false else {
            return false
        }
        
        
        let db = GetDBFromPath()
        db!.open()
        do {
            let query = "INSERT INTO Room (ID, Name , Icon , Sort , SectionID) VALUES (? , ? , ?, ? , ?)"
            try db!.executeUpdate(query, values: [room.id , room.name , room.icon ,  room.sort , room.sectionID])
            db!.close()
            return true
        }catch let err as NSError {
            Printer("DBManager insert Room error : \(err.debugDescription)")
            db!.close()
            return false
            
        }
    }
    
    /// BinMan1 : Get a Room object of Rooms from table
    class func getRoom(RoomID id : Int) -> RoomModel? {
        let db = GetDBFromPath()
        db!.open()
        do {
            let query = "SELECT * FROM Room WHERE ID = ?"
            let result = try db!.executeQuery(query, values: [id])
            let model = RoomModel()
            if result.next() {
                model.id = Int(result.intForColumn("ID"))
                model.icon = result.stringForColumn("Icon")
                model.name = result.stringForColumn("Name")
                model.sort = Int(result.intForColumn("Sort"))
                model.sort = Int(result.intForColumn("SectionID"))
            }
            db!.close()
            return model
        }catch let err as NSError {
            Printer("DBManager get specific Room error : \(err.debugDescription)")
            db!.close()
            return nil
        }
    }
    
    
    /// BinMan1 : Get All Rooms From Room table
    class func getAllRoomsById(SectionID id : Int) -> [RoomModel]? {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "SELECT * FROM Room WHERE SectionID = ?"
            let result = try db!.executeQuery(query, values: [id])
            var models = [RoomModel]()
            while result.next() {
                let model = RoomModel()
                model.id = Int(result.intForColumn("ID"))
                model.name = result.stringForColumn("Name")
                model.icon = result.stringForColumn("Icon")
                model.sort = Int(result.intForColumn("Sort"))
                model.sectionID = Int(result.intForColumn("SectionID"))
                models.append(model)
            }
            db!.close()
            return models
        } catch let err as NSError {
            Printer("DBManager get All Section error : \(err.debugDescription)")
            db!.close()
            return nil
        }
    }
    
    /// Arash: Get All Rooms.
    class func getAllRooms()-> [RoomModel]?  {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "SELECT * FROM Room "
            let result = try db!.executeQuery(query, values: nil)
            var models = [RoomModel]()
            while result.next() {
                let model = RoomModel()
                model.id = Int(result.intForColumn("ID"))
                model.name = result.stringForColumn("Name")
                model.icon = result.stringForColumn("Icon")
                model.sort = Int(result.intForColumn("Sort"))
                model.sort = Int(result.intForColumn("SectionID"))
                models.append(model)
            }
            db!.close()
            return models
        } catch let err as NSError {
            Printer("DBManager get All Section error : \(err.debugDescription)")
            db!.close()
            return nil
        }
    }
    
    
    /// BinMan1 : Delete Room record from Room table
    class func deleteRoom(RoomID  id : Int) -> Bool {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "DELETE FROM Room WHERE ID = ?"
            try db!.executeUpdate(query, values: [id])
            db!.close()
            return true
        } catch let err as NSError {
            Printer("DBManager Delete Specific Room error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    
    
    /// BinMan1 : Delete All Rooms from Room table
    class func deleteAllRooms () -> Bool {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "DELETE FROM Room"
            try db!.executeUpdate(query, values: nil)
            db!.close()
            return true
        } catch let err as NSError {
            Printer("DBManager delete All Rooms error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    
    /// Arash: Update scenario
    class func updateScenario(model: ScenarioModel)->Bool {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "UPDATE Scenario SET Name=?,Active=?,ISStarted=?,Lat=?,Long=?,Distance=?,Description=?,Result=?,Condition=?,Des=? where ID=?"
            try db!.executeUpdate(query, values: [model.name , model.active , model.isStarted , model.lat , model.long , model.distance ,model.description , model.result , model.condition , model.des , model.id])
            db!.close()
            return true
        } catch let err as NSError {
            Printer("DBManager update scenario error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    /// Arash: Update switch status
    class func updateSwitchStatus(id : Int , value : Float)->Bool {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "UPDATE Switch SET Value=? where ID=?"
            try db!.executeUpdate(query, values: [value , id] )
            db!.close()
            return true
        } catch let err as NSError {
            Printer("DBManager update scenario error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    /// Arash: active scenario
    class func activeScenario(id: Int , active : Int)->Bool {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "update Scenario set Active=? where ID=?"
            try db!.executeUpdate(query, values: [active , id] )
            db!.close()
            return true
        } catch let err as NSError {
            Printer("DBManager active scenario error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    /// Arash: start scenario
    class func startScenario(id: Int , active : Int)->Bool {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "update Scenario set IsStarted=? where ID=?"
            try db!.executeUpdate(query, values: [active , id] )
            db!.close()
            return true
        } catch let err as NSError {
            Printer("DBManager active scenario error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    /// Arash: Update switch
    class func updateSwitch(model : SwitchModel)->Bool {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "update Switch set Name=?,Code=?,Value=? where ID=?"
            try db!.executeUpdate(query, values: [model.name , model.code , model.value , model.id])
            db!.close()
            return true
        } catch let err as NSError {
            Printer("DBManager update switch error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    /// Arash: Update node
    class func updateNode(model : NodeModel)->Bool {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "update Node set Name=?,Icon=?,NodeType=?,Status=? where ID=?"
            try db!.executeUpdate(query, values: [model.name , model.icon , model.nodeType , model.status , model.id])
            db!.close()
            return true
        } catch let err as NSError {
            Printer("DBManager update node error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    ///Arash: Delete section
    class func deleteSection(id : Int)->Bool {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "DELETE FROM Section WHERE ID=?"
            try db!.executeUpdate(query, values: [id])
            db!.close()
            return true
        } catch let err as NSError {
            Printer("DBManager delete section error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    /// Arash: Update section
    class func updateSection(model : SectionModel)-> Bool {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "UPDATE Section SET Name=?,Icon=?,Sort=? WHERE ID=?"
            try db!.executeUpdate(query, values: [model.name , model.icon , model.sort , model.id])
            db!.close()
            return true
        } catch let err as NSError {
            Printer("DBManager update section error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    
    /// Arash: Update room
    class func updateRoom(model : RoomModel)->Bool {
        let db = GetDBFromPath()
        db!.open()
        
        do {
            let query = "UPDATE Room SET Name=?,Icon=?,Sort=? WHERE ID=?"
            try db!.executeUpdate(query, values: [model.name , model.icon , model.sort , model.id])
            db!.close()
            return true
        } catch let err as NSError {
            Printer("DBManager update room error : \(err.debugDescription)")
            db!.close()
            return false
        }
    }
    
    /// Arash: Get Node Value
    class func getNodeValue(code : Int , nodeID node : Int)->Double? {
        let db = GetDBFromPath()
        db!.open()
        defer {db?.close()}
        
        do {
            var val = 0.0
            let query = "SELECT Value FROM Switch WHERE NodeID=? AND Code=?"
            let result = try db!.executeQuery(query, values: [node , code])
            while result.next() {
                val = result.doubleForColumn("Value")
            }
            return val
        } catch let err as NSError {
            Printer("DBManager get NodeValue error : \(err.debugDescription)")
            return nil
        }
    }
    
    ///Arash: Check if a node is favorite.
    class func isBookmark(id : Int)->Int {
        let db = GetDBFromPath()
        db!.open()
        defer {db!.close()}
        var isBookmark = -1
        do {
            let query = "select IsBookmark from Node where ID=?"
            let result = try db!.executeQuery(query, values: [id])
            while result.next() {
                isBookmark = Int(result.intForColumn("IsBookmark"))
            }
        } catch let err as NSError {
            Printer("DBManager isBookmark error : \(err.debugDescription)")
        }
        return isBookmark
    }
    
    ///Arash: Update a node bookmark(isfavorite or not.)
    class func updateNodeBookmark(id : Int , isBookmark favorite : Int)->Bool {
        let db = GetDBFromPath()
        db!.open()
        defer {db?.close()}
        
        do {
            let query = "UPDATE Node SET IsBookmark=? WHERE ID=?"
            try db!.executeUpdate(query, values: [favorite , id])
            return true
        } catch let err as NSError {
            Printer("DBManager updateNodeBookmark error : \(err.debugDescription)")
            return false
        }
    }
    
    ///Arash: Get switchmodel based on nodeID & code.
    class func getSwitchIDName(nodeID : Int , code : Int)->[SwitchModel]? {
        let db = GetDBFromPath()
        db!.open()
        defer {db!.close()}
        
        do {
            let query = "select ID,Name from Switch where NodeID=? and Code=?"
            let result = try db!.executeQuery(query, values: [nodeID , code])
            var models = [SwitchModel]()
            while result.next() {
                let model = SwitchModel()
                model.id = Int(result.intForColumn("ID"))
                model.name = result.stringForColumn("Name")
                models.append(model)
            }
            return models
        } catch let err as NSError {
            Printer("DBManager getSwitchIDName error : \(err.debugDescription)")
            return nil
        }
    }
    
    ///Arash: fetch all nodes of a room.
    class func getAllRoomNodes(roomID:Int)->[NodeModel]? {
        let db = GetDBFromPath()
        db!.open()
        defer {db!.close()}
        
        do {
            let query = "select * from Node where RoomID=?"
            let result = try db!.executeQuery(query, values: [roomID])
            var models = [NodeModel]()
            while result.next() {
                let model = NodeModel()
                model.id = Int(result.intForColumn("ID"))
                model.name = result.stringForColumn("Name")
                model.isBookmark = result.boolForColumn("IsBookmark")
                //                model.isBookmark = Bool(Int(result.intForColumn("IsBookmark")))
                model.icon = result.stringForColumn("Icon")
                model.nodeType = Int(result.intForColumn("NodeType"))
                model.roomID = roomID
                model.status = Int(result.intForColumn("Status"))
                models.append(model)
            }
            return models
        } catch let err as NSError {
            Printer("DBManager getSwitchIDName error : \(err.debugDescription)")
            return nil
        }
    }
    
    
    
    /// Arash: Delete All
    class func deleteAll() {
        deleteAllNodes()
        deleteAllRooms()
        deleteAllNotifies()
        deleteAllSections()
        deleteAllSwitches()
        deleteAllScenarios()
    }
    
    /// Arash: Resetfactory
    class func resetFactory() {
        DBManager.deleteAll()
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.LanguageID, UpdateValue: "1")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.ServerIP, UpdateValue: "")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.ServerPort, UpdateValue: "")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.CustomerID, UpdateValue: "")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.MobileID, UpdateValue: "")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.WiFiSSID, UpdateValue: "")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.WiFiMac, UpdateValue: "")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.CenterIP, UpdateValue: "")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.CenterPort, UpdateValue: "")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.LastMessageID, UpdateValue: "0")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.ExKey, UpdateValue: "")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.CustomerName, UpdateValue: "")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.Register, UpdateValue: "0")
        DBManager.updateValuesOfSettingsDB(Type: TypeOfSettings.Ver, UpdateValue: "1")
    }
}

