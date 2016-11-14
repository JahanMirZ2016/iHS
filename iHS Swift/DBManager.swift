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
        db.open()
        do {
            var resultStringArray = Array<String>()
            for id in ids {
                let result = try db.executeQuery("SELECT * FROM Translation WHERE Translation.LangID = \(SELECTEDLANGID) AND Translation.SentenseID = \(id)", values: nil)
                if result.next() {
                    resultStringArray.append(result.stringForColumn("SentenseText"))
                }
            }
            
            db.close()
            return resultStringArray
        } catch let error as NSError{
            Printer("DBManger Get Translation Error : \(error.debugDescription)")
            db.close()
            return Array<String>()
        }
    }
    
    
    
    /// BinMan1 : Get specific value of Settings types
    class func getValueOfSettingsDB (Type type : String ) -> String? {
        let db = GetDBFromPath()
        db.open()
        do {
            var resultString = String()
            let query = "SELECT * FROM Settings WHERE Settings.type = ?"
            let result = try db.executeQuery(query, values: [type])
            if result.next() {
                resultString = result.stringForColumn("value")
            }
            db.close()
            return resultString
        } catch let err as NSError {
            Printer("DBManger Getting settings error : \(err.debugDescription)")
            db.close()
            return nil
        }
        
    }
    
    /// BinMan1 : Update value of types in Setting DB
    class func updateValuesOfSettingsDB (Type type : String , UpdateValue value : String) -> Bool {
        let db = GetDBFromPath()
        db.open()
        do {
            let query = "UPDATE Settings SET Settings.value = ? WHERE Settings.type = ?"
            try db.executeUpdate(query, values: [value , type])
            db.close()
            return true
        } catch let err as NSError {
            Printer("DBManger update settings error : \(err.debugDescription)")
            db.close()
            return false
        }
    }
    
    
    /// BinMan1 : Inser A node to DB
    class func insertNode(NodeModel node : NodeModel) -> Bool {
        let db = GetDBFromPath()
        db.open()
        do {
            let query = "INSERT INTO Node (ID, Name , Icon , NodeType,IsBookMark, RoomID , Status) VALUES (?, ? , ? , ? , ? , ? , ?)"
            try db.executeUpdate(query, values: [node.id , node.name , node.icon , node.nodeType , node.isBookmark , node.roomID, node.status])
            db.close()
            return true
        }catch let err as NSError {
            Printer("DBManager insert node error : \(err.debugDescription)")
            db.close()
            return false
        }
    }
    
    /// BinMan1 : Get a specific object of nodes from table
    class func getNode(NodeID id : Int) -> NodeModel? {
        let db = GetDBFromPath()
        db.open()
        do {
            let query = "SELECT * FROM Node WHERE Node.ID = ?"
            let result = try db.executeQuery(query, values: [id])
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
            db.close()
            return model
        }catch let err as NSError {
            Printer("DBManager get specific node error : \(err.debugDescription)")
            db.close()
            return nil
        }
    }
    
    /// BinMan1 : Get All Nodes From Node table
    class func getAllNodes() -> [NodeModel]? {
        let db = GetDBFromPath()
        db.open()
        
        do {
            let query = "SELECT * FROM Node"
            let result = try db.executeQuery(query, values: nil)
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
            db.close()
            return models
        } catch let err as NSError {
            Printer("DBManager get All nodes error : \(err.debugDescription)")
            db.close()
            return nil
        }
    }
    
    
    /// BinMan1 : Delete specific record from Node table
    class func deleteNode(NodeID  id : Int) -> Bool {
        let db = GetDBFromPath()
        db.open()
        
        do {
            let query = "DELETE FROM Node WHERE ID = ?"
            try db.executeUpdate(query, values: [id])
            db.close()
            return true
        } catch let err as NSError {
            Printer("DBManager get All nodes error : \(err.debugDescription)")
            db.close()
            return false
        }
    }
    
    
    /// BinMan1 : Delete All Nodes from Node table
    class func deleteAllNodes () -> Bool {
        let db = GetDBFromPath()
        db.open()
        
        do {
            let query = "DELETE FROM Node"
            try db.executeUpdate(query, values: nil)
            db.close()
            return true
        } catch let err as NSError {
            Printer("DBManager get All nodes error : \(err.debugDescription)")
            db.close()
            return false
        }
    }
    
    
    /// BinMan1 : Insert Notify to table
    class func insertNotify(NotifyModel notify : NotifyModel) -> Bool {
        let db = GetDBFromPath()
        db.open()
        do {
            let query = "INSERT INTO Notify (ID, NotifyTitle , NotifyText ,Seen) VALUES (?, ? , ? , ? )"
            try db.executeUpdate(query, values: [notify.id , notify.notifyTitle , notify.notifyText , notify.seen])
            db.close()
            return true
        }catch let err as NSError {
            Printer("DBManager insert node error : \(err.debugDescription)")
            db.close()
            return false
        }
    }
    
    /// BinMan1 : Get a notify object of nodes from table
    class func getNotify(NodeID id : Int) -> NotifyModel? {
        let db = GetDBFromPath()
        db.open()
        do {
            let query = "SELECT * FROM Notify WHERE Notify.ID = ?"
            let result = try db.executeQuery(query, values: [id])
            let model = NotifyModel()
            if result.next() {
                model.id = Int(result.intForColumn("ID"))
                model.notifyTitle = result.stringForColumn("NotifyTitle")
                model.notifyText = result.stringForColumn("NotifyText")
                model.seen = result.boolForColumn("Seen")
            }
            db.close()
            return model
        }catch let err as NSError {
            Printer("DBManager get specific node error : \(err.debugDescription)")
            db.close()
            return nil
        }
    }
    
    
    /// BinMan1 : Get All Nodes From Node table
    class func getAllNotifies() -> [NotifyModel]? {
        let db = GetDBFromPath()
        db.open()
        
        do {
            let query = "SELECT * FROM Notify"
            let result = try db.executeQuery(query, values: nil)
            var models = [NotifyModel]()
            while result.next() {
                let model = NotifyModel()
                model.id = Int(result.intForColumn("ID"))
                model.notifyTitle = result.stringForColumn("NotifyTitle")
                model.notifyText = result.stringForColumn("NotifyText")
                model.seen = result.boolForColumn("Seen")
                models.append(model)
            }
            db.close()
            return models
        } catch let err as NSError {
            Printer("DBManager get All nodes error : \(err.debugDescription)")
            db.close()
            return nil
        }
    }
    
    
    /// BinMan1 : Delete specific record from Notify table
    class func deleteNotify(NotifyID  id : Int) -> Bool {
        let db = GetDBFromPath()
        db.open()
        
        do {
            let query = "DELETE FROM Notify WHERE ID = ?"
            try db.executeUpdate(query, values: [id])
            db.close()
            return true
        } catch let err as NSError {
            Printer("DBManager get All nodes error : \(err.debugDescription)")
            db.close()
            return false
        }
    }
    
    
    /// BinMan1 : Delete All Notifies from Notify table
    class func deleteAllNotifies () -> Bool {
        let db = GetDBFromPath()
        db.open()
        
        do {
            let query = "DELETE FROM Notify"
            try db.executeUpdate(query, values: nil)
            db.close()
            return true
        } catch let err as NSError {
            Printer("DBManager get All nodes error : \(err.debugDescription)")
            db.close()
            return false
        }
    }
    
    /// BinMan1 : Insert Notify to table
    class func insertScenario(ScenarioModel scenario : ScenarioModel) -> Bool {
        let db = GetDBFromPath()
        db.open()
        do {
            let query = "INSERT INTO Scenario (ID, Name , Active , IsStarted ,Lat ,Long, Distance , Description ,Result,Condition, Des ) VALUES (?, ? , ? , ? )"
            try db.executeUpdate(query, values: [scenario.id , scenario.name , scenario.])
            db.close()
            return true
        }catch let err as NSError {
            Printer("DBManager insert node error : \(err.debugDescription)")
            db.close()
            return false
        }
    }
    
    /// BinMan1 : Get a notify object of nodes from table
    class func getNotify(NodeID id : Int) -> NotifyModel? {
        let db = GetDBFromPath()
        db.open()
        do {
            let query = "SELECT * FROM Notify WHERE Notify.ID = ?"
            let result = try db.executeQuery(query, values: [id])
            let model = NotifyModel()
            if result.next() {
                model.id = Int(result.intForColumn("ID"))
                model.notifyTitle = result.stringForColumn("NotifyTitle")
                model.notifyText = result.stringForColumn("NotifyText")
                model.seen = result.boolForColumn("Seen")
            }
            db.close()
            return model
        }catch let err as NSError {
            Printer("DBManager get specific node error : \(err.debugDescription)")
            db.close()
            return nil
        }
    }
    
    
    /// BinMan1 : Get All Nodes From Node table
    class func getAllNotifies() -> [NotifyModel]? {
        let db = GetDBFromPath()
        db.open()
        
        do {
            let query = "SELECT * FROM Notify"
            let result = try db.executeQuery(query, values: nil)
            var models = [NotifyModel]()
            while result.next() {
                let model = NotifyModel()
                model.id = Int(result.intForColumn("ID"))
                model.notifyTitle = result.stringForColumn("NotifyTitle")
                model.notifyText = result.stringForColumn("NotifyText")
                model.seen = result.boolForColumn("Seen")
                models.append(model)
            }
            db.close()
            return models
        } catch let err as NSError {
            Printer("DBManager get All nodes error : \(err.debugDescription)")
            db.close()
            return nil
        }
    }
    
    
    /// BinMan1 : Delete specific record from Notify table
    class func deleteNotify(NotifyID  id : Int) -> Bool {
        let db = GetDBFromPath()
        db.open()
        
        do {
            let query = "DELETE FROM Notify WHERE ID = ?"
            try db.executeUpdate(query, values: [id])
            db.close()
            return true
        } catch let err as NSError {
            Printer("DBManager get All nodes error : \(err.debugDescription)")
            db.close()
            return false
        }
    }
    
    
    /// BinMan1 : Delete All Notifies from Notify table
    class func deleteAllNotifies () -> Bool {
        let db = GetDBFromPath()
        db.open()
        
        do {
            let query = "DELETE FROM Notify"
            try db.executeUpdate(query, values: nil)
            db.close()
            return true
        } catch let err as NSError {
            Printer("DBManager get All nodes error : \(err.debugDescription)")
            db.close()
            return false
        }
    }
}
