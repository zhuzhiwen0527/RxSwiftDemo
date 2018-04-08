//
//  userModel.swift
//  rxSwiftDemo
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import HandyJSON

struct  User: HandyJSON {
  
    var id = ""
    var phone = ""
    var usign = ""
    
    
}

struct userModel: HandyJSON {
    var msg = ""
    var status = ""
    var code:Bool = false
    var success = ""
    var userinfor = User()
    var token = ""
    var yuntoken = ""
    var accid = ""
}
