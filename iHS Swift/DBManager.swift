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
            let query = "SELECT * FROM Settings WHERE Settings.type = \(type)"
            let result = try db.executeQuery(query, values: nil)
            if result.next() {
                resultString = result.stringForColumn("value")
            }
            db.close()
            return resultString
        } catch let err as NSError {
            Printer("DBManger update settings error : \(err.debugDescription)")
            db.close()
            return nil
        }
        
    }
    
    /// BinMan1 : Update value of types in Setting DB
    class func updateValuesOfSettingsDB (Type type : String , UpdateValue value : String) -> Bool {
        let db = GetDBFromPath()
        db.open()
        do {
            let query = "UPDATE Settings SET Settings.value = \(value) WHERE Settings.type = \(type)"
            try db.executeUpdate(query, values: nil)
            db.close()
            return true
        } catch let err as NSError {
            Printer("DBManger update settings error : \(err.debugDescription)")
            db.close()
            return false
        }
    }
}
