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
    var sendername = ""
    var lat = ""
    var lng = ""
    var imgurl = ""
    var content = ""
    var id = ""
    var senderpic = ""
    var sendtime = ""
    var contentH:CGFloat{
        if content.count == 0 {
            return 0.0
        }
        let font = UIFont.systemFont(ofSize: 15)
        let rect = NSString(string: content.removingPercentEncoding!).boundingRect(with: CGSize(width: UIScreen.main.bounds.size.width-74.5, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return rect.height+10.0
    }
    
    
    var cellH:CGFloat{
        
        return imgVSize.height+12.0+21.0+contentH+20.0+20.0+5.0
    }
    
    
    var imgArrs:Array<String>{
        var imgs = imgurl.components(separatedBy: ",").map {
            
            return "http://iyouwen-1.oss-cn-shanghai.aliyuncs.com/\($0)"
        }
        imgs.removeLast()
        
        return imgs
    }
    var imgVSize:CGSize{
        
        let imgUrls = imgurl.components(separatedBy: ",")
    
        if imgUrls.count == 2 {
            
            
            let arr = imgUrls[0].components(separatedBy: "hhh")
            if arr.count == 1{ return CGSize(width: 0, height: 0)}
            let arr1 = arr[1].components(separatedBy: "kkk")
            let w = (arr1[0] as NSString).floatValue
            let h = (arr1[1] as NSString).floatValue
            var rw:Float = 0.0
 
            if (w < h) {
                rw = 124.0;
                
            }else{
                rw = 171.0;
            }
                let rh = (rw*h/w)+10
            return CGSize(width: CGFloat(rw), height: CGFloat(rh))
            
        }else if imgUrls.count>2 {
            
            let imageCount = imgUrls.count-1;
            let perRowImageCount = ((imageCount == 4) ? 2 : 3);
            let totalRowCount = ceil(Float(imageCount)/Float(perRowImageCount));
       
            let rw = UIScreen.main.bounds.size.width-64.5
            let h = (rw-40)/3.0
            let r = CGFloat(totalRowCount)
            let rh = r*(10+h);
            
            return CGSize(width: rw, height: rh)
        }else{
            
            return CGSize(width: 0, height: 0)
        }
        
     
        
    }
    

    
    
    
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
