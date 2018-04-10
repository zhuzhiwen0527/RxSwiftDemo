
//
//  ZWCalendarViewController.swift
//  rxSwiftDemo
//
//  Created by apple on 2018/4/10.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import ZWCalendarView
class ZWCalendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "日历"
        //oc 组件化
        let v = ZWCalendarView(frame: CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height-64))
            view.addSubview(v)
     
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
