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
    
    
    /// BinMan1 : Get Language ID From DB
    class func getLanguageID () -> Int {
        let db = GetDBFromPath()
        db.open()
        do {
            var LangID : Int = Int()
            let result = try db.executeQuery("SELECT * FROM Settings WHERE type = 'LanguageID'", values: nil)
            if result.next() {
                LangID = Int(result.intForColumn("value"))
            }
            db.close()
            return LangID
        } catch let error as NSError {
            Printer("DBManger Get Language ID Error : \(error.debugDescription)")
            db.close()
            return -1
        }
    }
    
    
    /// BinMan1 : Set Language ID To DB
    class func setLanguageID (SelectedLanguageID id : Int) {
        let db = GetDBFromPath()
        db.open()
        do {
            try db.executeUpdate("UPDATE Settings SET value = %d WHERE type = 'LanguageID'", values: [id])
        } catch let error as NSError {
            Printer("DBManager Set Language ID Error : \(error.debugDescription)")
        }
        db.close()
    }
    
}
