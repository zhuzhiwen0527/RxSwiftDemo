//
//  ZWLoginViewController.swift
//  rxSwiftDemo
//
//  Created by zzw on 2018/3/30.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import CYLTabBarController
class ZWLoginViewController: UIViewController {

    var accountNumberTextFiled:UITextField!
    
    var accountnumberLab:UILabel!
    
    var passWordTextFiled:UITextField!
    
    var loginBtn:UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let mainVC = ZWMainTabBarViewController.creatTabBarVC()
        view.backgroundColor = UIColor.white
        createUI()
        
    }
    
    
    func createUI()  {
        
       accountNumberTextFiled = UITextField().then {
            $0.textColor = UIColor.black
            $0.placeholder = "输入账号"
            $0.borderStyle = UITextBorderStyle.bezel
            $0.font = UIFont.systemFont(ofSize: 14)
            view.addSubview($0)
            $0.snp.makeConstraints({
                $0.top.equalTo(view).offset(150)
                $0.left.equalTo(view).offset(30)
                $0.right.equalTo(view).offset(-30)
                $0.height.equalTo(50)
            })
 
        }
       accountnumberLab = UILabel().then({
            $0.textColor = UIColor.gray
            $0.font = UIFont.systemFont(ofSize: 11)
            $0.text = "请输入账号"
            view.addSubview($0)
            $0.snp.makeConstraints({ (make) in
                make.top.equalTo((accountNumberTextFiled?.snp.bottom)!).offset(2)
                make.left.right.equalTo(accountNumberTextFiled!)
                make.height.equalTo(20)
            })
        })
        
        
        passWordTextFiled =  UITextField().then {
            $0.textColor = UIColor.black
            $0.placeholder = "输入密码"
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.borderStyle = UITextBorderStyle.bezel
            view.addSubview($0)
            $0.snp.makeConstraints({
                $0.top.equalTo(accountnumberLab.snp.bottom).offset(2)
                $0.left.right.equalTo(accountNumberTextFiled!)
                $0.height.equalTo(50)
            })
        }
        
        loginBtn = UIButton().then({
            
            $0.setTitle("登录", for: .normal)
            $0.backgroundColor = UIColor.brown
            $0.setTitleColor(UIColor.red, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            $0.isEnabled = false
            view.addSubview($0)
            $0.snp.makeConstraints({
                $0.top.equalTo(passWordTextFiled.snp.bottom).offset(20)
                $0.left.right.equalTo(accountNumberTextFiled!)
                $0.height.equalTo(60)
            })
        })
        
        
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
