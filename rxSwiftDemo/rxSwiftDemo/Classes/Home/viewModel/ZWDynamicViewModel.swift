//
//  ZWDynamicViewModel.swift
//  rxSwiftDemo
//
//  Created by apple on 2018/4/9.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


enum ZWRefreshStatus {
    case none
    case endRefresh
    case noMoreData
}

class  ZWDynamicViewModel :NSObject{

    let models = Variable<[ZWModel]>([])
    var index:Int = 0
    

    
}

extension ZWDynamicViewModel:ZWViewModelType{

    
    typealias Input = ZWInput
    typealias Output = ZWOutput
    
    struct ZWInput {
        // 传递参数
        
        var name = ""
        
        
        init(name:String) {
            self.name = name
        }
    }
    
    struct ZWOutput {
        // tableView的sections数据
        let sections: Driver<[ZWSection]>
        // 外界通过该属性告诉viewModel加载数据（传入的值是为了标志是否重新加载）
        let requestCommond = PublishSubject<Bool>()
 
        // 告诉外界的tableView当前的刷新状态
        let refreshStatus = Variable<ZWRefreshStatus>(.none)
        init(sections: Driver<[ZWSection]>) {
            self.sections = sections
        }
    }
    
    func transform(input: ZWDynamicViewModel.ZWInput) -> ZWDynamicViewModel.ZWOutput {
        let sections = models.asObservable().map { (models) -> [ZWSection] in
            // 当models的值被改变时会调用
       
            return [ZWSection(items: models)]
            }.asDriver(onErrorJustReturn: [])
        
        print(input.name)
        
        let output = ZWOutput(sections: sections)
        
        output.requestCommond.subscribe(onNext: {[unowned self] isReloadData in
               self.index = isReloadData ? 0 : self.index+1
            zwNetTool.rx.request(.dynamicData(token: UserDefaults.standard.value(forKey: "token") as! String, pagesize: "40", pageindex: "\(self.index)")).asObservable().mapArray(ZWModel.self).subscribe({ [weak self] (event) in
                switch event {
                case let .next(modelArr):
             
                self?.models.value = isReloadData ? modelArr : (self?.models.value ?? []) + modelArr
                modelArr.count == 0 ? (output.refreshStatus.value = .noMoreData) :  (output.refreshStatus.value = .endRefresh)
                
                case .error(_):
                output.refreshStatus.value = .endRefresh
                case .completed:break
           
                }
            }).disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)
        
        return output
    }
    
    
}

