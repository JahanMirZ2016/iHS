//
//  JsonMaker.swift
//  SmartHouse
//
//  Created by MAC on 1/20/16.
//  Copyright © 2016 BinMan1. All rights reserved.
//

import Foundation

public class JsonMaker {
    public class func dictionaryToJson(dic : Dictionary<String , AnyObject>) ->String {
        var str = String()
        do {
            let json = try NSJSONSerialization.dataWithJSONObject(dic, options: NSJSONWritingOptions(rawValue: 0))
            str = String(data: json, encoding: NSUTF8StringEncoding)!
            str += "\n"
            print(str)
        } catch let error as NSError {
            print(error)
        }
        return str
    }
    
    public class func arrayToJson(array : NSArray) ->String {
        var str = String()
        do {
            let json = try NSJSONSerialization.dataWithJSONObject(array, options: NSJSONWritingOptions(rawValue: 0))
            str = String(data: json, encoding: NSUTF8StringEncoding)!
            str += "\n"
            print(str)
        } catch let error as NSError {
            print(error)
        }
        return str
    }
    
    public class func stringToJson (dataString : NSMutableString) -> Dictionary<String , AnyObject> {
        let data = dataString.dataUsingEncoding(NSUTF8StringEncoding)
        var json = Dictionary<String , AnyObject>()
        
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! Dictionary<String , AnyObject>
        } catch let err as NSError {
            print(err)
        }
        return json
    }
    
    public class func jsonToDictionary (data : NSData) -> Dictionary<String , AnyObject> {
        var resualt = Dictionary<String , AnyObject>()
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            if let res = json as? Dictionary<String , AnyObject> {
                resualt = res
            } else {
                print("Cant parse json data...!!!!!")
            }
        } catch let err as NSError {
            print(err)
        }
        return resualt
    }
    
    public class func jsonToDictionaryArray (data : NSData) -> Array<Dictionary<String , AnyObject>> {
        var result = Array<Dictionary<String , AnyObject>>()
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            if let res = json as? Array<Dictionary<String , AnyObject>> {
                result = res
            } else {
                print("Cant parse json data...!!!!!")
            }
        } catch let err as NSError {
            print(err)
        }
        return result
    }

}
