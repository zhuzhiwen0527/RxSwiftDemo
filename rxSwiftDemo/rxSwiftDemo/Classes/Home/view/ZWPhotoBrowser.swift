//
//  ZWPhotoBrowser.swift
//  rxSwiftDemo
//
//  Created by apple on 2018/4/9.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import SKPhotoBrowser
import Kingfisher
import YYCategories
class ZWPhotoBrowser: UIView {
    
    var images = [SKPhoto]()
    
    func createBtn(btnDataSource:Array<String>) {
        images.removeAll()
    let _ = self.subviews.map {
           $0.removeFromSuperview()
        }
        NSArray(array: btnDataSource).enumerateObjects {url,idx,_ in
            
            let btn = UIButton().then({
                $0.kf.setImage(with: URL(string:url as! String), for: .normal)
                $0.imageView?.contentMode = .scaleAspectFill
                $0.tag = idx
                $0.addTarget(self, action:  #selector(buttonTap(button:)), for: .touchUpInside)
                
            })
            let photo = SKPhoto.photoWithImageURL(url as! String)
            photo.shouldCachePhotoURLImage = false // you can use image cache by true(NSCache)
            images.append(photo)
            self.addSubview(btn)
        }
    }
    @objc func buttonTap(button:UIButton)  {
      
        let browser = SKPhotoBrowser(originImage: button.currentImage!, photos: images, animatedFromView: button)
        browser.initializePageIndex(button.tag)

        self.viewController?.present(browser, animated: true, completion: {})
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        if self.subviews.count == 1 {
            let v = self.subviews[0];
            v.snp.updateConstraints({ (make) in
                make.left.top.equalTo(self)
                make.size.equalTo(self.snp.size)
            })
        
 
        }else{
            
            let imageCount = self.subviews.count;
            let perRowImageCount = ((imageCount == 4) ? 2 : 3);

            let rw = UIScreen.main.bounds.size.width-64.5-40
            let h = rw/3.0
            
            (self.subviews as NSArray).enumerateObjects({ (b, idx, _) in
                let btn = b as! UIButton
                let rowIndex = idx / perRowImageCount;
                let columnIndex = idx % perRowImageCount;
                let x = CGFloat(columnIndex) * (h + 10);
                let y = CGFloat(rowIndex) * (h + 10)+5;
                btn.snp.updateConstraints({ (make) in
                    make.left.equalTo(self).offset(x)
                    make.top.equalTo(self).offset(y)
                    make.size.equalTo(CGSize(width: h, height: h))
                })
                
            })
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
