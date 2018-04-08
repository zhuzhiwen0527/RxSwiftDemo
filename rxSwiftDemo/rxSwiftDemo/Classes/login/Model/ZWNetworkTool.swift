//
//  ZWNetworkTool.swift
//  rxSwiftDemo
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 zzw. All rights reserved.
//

import Foundation
import Moya

enum ZWNetworkTool {
    // 18237100685  yw12345
    case user(username:String,password:String)
 
}
extension ZWNetworkTool:TargetType {
    var headers: [String : String]? {
        return [:]
    }

    /// The target's base `URL`.
    var baseURL: URL {
        switch self {
        case .user( _,  _):
            return URL(string:"http://www.igewen.com/")!
   
        }
     
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .user( _,  _):
            return "app/login/check"
       
        }
        
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
 
        return .post

   
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return "单元测试".data(using: .utf8)!
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        switch self {
        case .user(let username, let password):
            return .requestParameters(parameters: ["phone":username,"pwd":password], encoding: URLEncoding.default)

        }
       
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }

    
}
let zwNetTool = MoyaProvider<ZWNetworkTool>()
