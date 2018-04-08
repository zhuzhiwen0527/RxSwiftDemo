//
//  ZWModel.swift
//  rxSwiftDemo
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import HandyJSON
import RxDataSources
struct  ZWModel: HandyJSON {
 
    
}
/* ============================= SectionModel =============================== */

struct ZWSection {
    
    var items: [Item]
}

extension ZWSection: SectionModelType {
    
    typealias Item = ZWModel
    
    init(original: ZWSection, items: [ZWSection.Item]) {
        self = original
        self.items = items
    }
}
