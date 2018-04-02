//
//  userModel.swift
//  rxSwiftDemo
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import ObjectMapper

class User: Mappable {
    var accid = ""
    var code = ""
    var msg = ""
    var usertoken = ""
    var yuntoken = ""
    
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        accid        <- map["accid"]
        code   <- map["code"]
        msg       <- map["msg"]
        usertoken <- map["usertoken"]
        yuntoken     <- map["yuntoken"]
        
    }
}

class userModel: Mappable {
    var msg = ""
    var status = ""
    var code:Bool = false
    var success = ""
    var users :User?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        msg       <- map["msg"]
        code   <- map["code"]
        status       <- map["status"]
        success <- map["success"]
        users <- map["data"]
        
    }
}
