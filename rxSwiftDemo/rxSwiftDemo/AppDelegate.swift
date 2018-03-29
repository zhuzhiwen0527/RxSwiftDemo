//
//  AppDelegate.swift
//  rxSwiftDemo
//
//  Created by apple on 2018/3/28.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import CYLTabBarController
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        let mainTabBarController = ZWMainTabBarViewController(viewControllers: self.viewControllers(), tabBarItemsAttributes: self.tabBarItemsAttributesForController())
        self.window = UIWindow()
        self.window?.frame = UIScreen.main.bounds
        self.window?.rootViewController = mainTabBarController
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func viewControllers() -> [UINavigationController] {
        let first = UINavigationController(rootViewController: ViewController())
        let second = UINavigationController(rootViewController: UIViewController())
        
       return[first,second]
    }
    func tabBarItemsAttributesForController() -> [[String:String]] {
        let itemOne = [CYLTabBarItemTitle:"one",
                       CYLTabBarItemImage:"xiaoxi",
                       CYLTabBarItemSelectedImage:"xiaoxi-red"]
        let itemTwo = [CYLTabBarItemTitle:"Two",
                       CYLTabBarItemImage:"faxian",
                       CYLTabBarItemSelectedImage:"faxian-red"]
        return [itemOne,itemTwo]
    }
}

