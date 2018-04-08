//
//  ZWWeitoutiaoNetTool.swift
//  rxSwiftDemo
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import Moya
let device_id: Int = 6096495334
let iid: Int = 5034850950
let pullTime = Date().timeIntervalSince1970

let params = ["device_id": device_id,
              "count": 20,
              "list_count": 15,
              "category": "ugc_video_beauty",
              "min_behot_time": pullTime,
              "strict": 0,
              "detail": 1,
              "refresh_reason": 1,
              "tt_from": "pull",
              "iid": iid] as [String: Any]
enum ZWWeitoutiaoNetTool {
   
    case weitoutiao
}
extension ZWWeitoutiaoNetTool:TargetType {
    var baseURL: URL {
        return URL(fileURLWithPath: "https://is.snssdk.com")
    }
    
    var path: String {
        return "api/news/feed/v75"
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        
        return .get
        
    }
    
    var sampleData: Data {
        return "单元测试".data(using: .utf8)!
    }
    
    var task: Task {
  
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
    
}
let zwWeitoutiaoTool = MoyaProvider<ZWWeitoutiaoNetTool>()
