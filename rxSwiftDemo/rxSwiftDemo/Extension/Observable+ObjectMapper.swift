//
//  Observable+ObjectMapper.swift
//  rxSwiftDemo
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 zzw. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import HandyJSON
// MARK: - Json -> Model
extension Response {
    // 将Json解析为单个Model
    public func mapObject<T: HandyJSON>(_ type: T.Type) throws -> T {
    
        guard let object = T.deserialize(from: try mapString()) else {
            throw MoyaError.jsonMapping(self)
        }
      
        return object
    }
    
    // 将Json解析为多个Model，返回数组，对于不同的json格式需要对该方法进行修改
    public func mapArray<T:HandyJSON>(_ type: T.Type) throws -> [T] {
        
        guard let json = try mapJSON() as? [String : Any] else {
            throw MoyaError.jsonMapping(self)
        }
        
        guard let jsonArr = (json["data"] as? [[String : Any]]) else {
            throw MoyaError.jsonMapping(self)
        }
        
      
    
        return   jsonArr.flatMap {T.deserialize(from: $0)}
    }
}

// MARK: - Json -> Observable<Model>
extension ObservableType where E == Response {
    // 将Json解析为Observable<Model>
    public func mapObject<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
   
        return flatMap { response -> Observable<T> in
            print("发起网络请求")
            print(response)
            return Observable.just(try response.mapObject(T.self))
        }
    }
    // 将Json解析为Observable<[Model]>
    public func mapArray<T: HandyJSON>(_ type: T.Type) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray(T.self))
        }
    }
}
