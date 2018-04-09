//
//  ZWViewModelType.swift
//  rxSwiftDemo
//
//  Created by apple on 2018/4/9.
//  Copyright © 2018年 zzw. All rights reserved.
//

import Foundation
protocol ZWViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
