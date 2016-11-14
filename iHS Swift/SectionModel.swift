//
//  SectionModel.swift
//  iHS Swift
//
//  Created by arash on 11/14/16.
//  Copyright © 2016 Ali Zare Sh. All rights reserved.
//

import Foundation

class SectionModel {
    
    var id:Int = 0
    var name:String = ""
    var icon:String = ""
    var sort:Int = 0
    var cells = [RoomModel]()
    var collapsed:Bool = false
    
}
