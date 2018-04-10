//
//  ZWMainTabBarViewController.swift
//  rxSwiftDemo
//
//  Created by apple on 2018/3/29.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import CYLTabBarController
class ZWMainTabBarViewController: CYLTabBarController {


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    static  func creatTabBarVC() -> ZWMainTabBarViewController {
        let  tabBar = UITabBarItem.appearance()
        tabBar.setTitleTextAttributes([.foregroundColor : UIColor.gray], for: .normal)
        tabBar.setTitleTextAttributes([.foregroundColor : UIColor.red], for: .selected)
        
        return ZWMainTabBarViewController(viewControllers: ZWMainTabBarViewController.viewControllers(), tabBarItemsAttributes: ZWMainTabBarViewController.tabBarItemsAttributesForController())
    }


   static func viewControllers() -> [UINavigationController] {
        let baseVC = UINavigationController(rootViewController: ViewController())
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let calendar = UINavigationController(rootViewController: ZWCalendarViewController())
        return[homeVC,baseVC,calendar]
    }
    
    
    static  func tabBarItemsAttributesForController() -> [[String:String]] {
        let itemOne = [CYLTabBarItemTitle:"首页",
                       CYLTabBarItemImage:"xiaoxi",
                       CYLTabBarItemSelectedImage:"xiaoxi-red"]
        let itemTwo = [CYLTabBarItemTitle:"基础",
                       CYLTabBarItemImage:"faxian",
                       CYLTabBarItemSelectedImage:"faxian-red"]
        let itemThree = [CYLTabBarItemTitle:"日历",
                       CYLTabBarItemImage:"faxian",
                       CYLTabBarItemSelectedImage:"faxian-red"]
        return [itemOne,itemTwo,itemThree]
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
