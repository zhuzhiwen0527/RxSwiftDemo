//
//  AppDelegate.swift
//  rxSwiftDemo
//
//  Created by apple on 2018/3/28.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       

        
        let loginVC = ZWLoginViewController()
        
        self.window = UIWindow()
        self.window?.frame = UIScreen.main.bounds
        
        self.window?.rootViewController = loginVC
        self.window?.makeKeyAndVisible()
        
        return true
    }


}

