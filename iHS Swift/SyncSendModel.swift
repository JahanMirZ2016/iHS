//
//  SyncSendModel.swift
//  iHS Swift
//
//  Created by arash on 11/17/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

/*
 Arash : SyndSend Model
 */

import Foundation

class SyncSendModel {
    
    var SyncData:[SyncDataModel] = [SyncDataModel]()
    var MessageID:String = "0"
    var RecieverID:String = ""
    var Type:String = "SyncData"
    var Action:String = "Update"
    var Date:String = ""
    
}
