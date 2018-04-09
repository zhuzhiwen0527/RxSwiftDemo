//
//  ZWPhotoBrowser.swift
//  rxSwiftDemo
//
//  Created by apple on 2018/4/9.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import SKPhotoBrowser
class ZWPhotoBrowser: UIView {
    
    func createBtn(btnDataSource:Array<String>) {
        
        self.subviews.map {
           $0.removeFromSuperview()
        }
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
