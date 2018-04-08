//
//  ZWLoginViewController.swift
//  rxSwiftDemo
//
//  Created by zzw on 2018/3/30.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import CYLTabBarController
import SVProgressHUD
class ZWLoginViewController: UIViewController {

    var accountNumberTextFiled:UITextField!
    
    var passWordTextFiled:UITextField!
    
    var loginBtn:UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        createUI()
        bindViewModel()
    }
    
    
    func createUI()  {
        
        
        let accountNumberLab = UILabel().then {
            $0.textColor = UIColor.init(red: 51.0/255, green: 51.0/255, blue: 51.0/255, alpha: 1)
            $0.font = UIFont.systemFont(ofSize: 15)
            $0.text = "账号"
            view.addSubview($0)
            $0.snp.makeConstraints({
                $0.left.equalTo(view).offset(30)
                $0.top.equalTo(view).offset(180)
                $0.width.equalTo(40)
                $0.height.equalTo(30)
            })
        }
        
       accountNumberTextFiled = UITextField().then {
            $0.textColor = UIColor.init(red: 51.0/255, green: 51.0/255, blue: 51.0/255, alpha: 1)
            $0.placeholder = "输入手机号"
            $0.keyboardType = UIKeyboardType.numberPad
            $0.font = UIFont.systemFont(ofSize: 15)
            $0.clearButtonMode = UITextFieldViewMode.whileEditing
            $0.text =  (UserDefaults.standard.value(forKey: "phone") != nil) ? UserDefaults.standard.value(forKey: "phone") as! String :""
            view.addSubview($0)
            $0.snp.makeConstraints({
                $0.top.equalTo(accountNumberLab)
                $0.left.equalTo(accountNumberLab.snp.right).offset(5)
                $0.right.equalTo(view).offset(-30)
                $0.height.equalTo(30)
            })
 
        }
        let _ = UIView().then {
            $0.backgroundColor = UIColor.init(red: 91.0/255, green: 91.0/255, blue: 91.0/255, alpha: 1)
            view.addSubview($0)
            $0.snp.makeConstraints({
                
                $0.top.equalTo(accountNumberLab.snp.bottom).offset(1)
                $0.left.equalTo(view).offset(30)
                $0.right.equalTo(view).offset(-30)
                $0.height.equalTo(0.5)
            })
        }
        
        
        let passWordLab = UILabel().then {
            $0.textColor = UIColor.init(red: 51.0/255, green: 51.0/255, blue: 51.0/255, alpha: 1)
            $0.font = UIFont.systemFont(ofSize: 15)
            $0.text = "密码"
            view.addSubview($0)
            $0.snp.makeConstraints({
                $0.left.equalTo(accountNumberLab)
                $0.top.equalTo(accountNumberLab.snp.bottom).offset(40)
                $0.width.equalTo(40)
                $0.height.equalTo(30)
            })
        }
        
        passWordTextFiled =  UITextField().then {
            $0.textColor = UIColor.black
            $0.placeholder = "输入密码"
            $0.font = UIFont.systemFont(ofSize: 15)
            $0.isSecureTextEntry = true
            $0.clearButtonMode = UITextFieldViewMode.whileEditing
            view.addSubview($0)
            $0.snp.makeConstraints({
                $0.top.equalTo(passWordLab)
                $0.left.right.equalTo(accountNumberTextFiled!)
                $0.height.equalTo(30)
            })
        }
        
        let _ = UIView().then {
            $0.backgroundColor = UIColor.init(red: 91.0/255, green: 91.0/255, blue: 91.0/255, alpha: 1)
            view.addSubview($0)
            $0.snp.makeConstraints({
                
                $0.top.equalTo(passWordLab.snp.bottom).offset(1)
                $0.left.equalTo(view).offset(30)
                $0.right.equalTo(view).offset(-30)
                $0.height.equalTo(0.5)
            })
        }
        
        loginBtn = UIButton().then({
            
            $0.setTitle("登录", for: .normal)
            $0.backgroundColor = UIColor.init(red: 243.0/255, green: 87.0/255, blue: 87.0/255, alpha: 1)
            $0.setTitleColor(UIColor.white, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            $0.isEnabled = false
            $0.layer.masksToBounds = true;
            $0.layer.cornerRadius = 5
            view.addSubview($0)
            $0.snp.makeConstraints({
                $0.top.equalTo(passWordTextFiled.snp.bottom).offset(30)
                $0.left.equalTo(accountNumberLab)
                $0.right.equalTo(accountNumberTextFiled!)
                $0.height.equalTo(40)
            })
        })
        
        
    }
    
    func bindViewModel(){
        
        let viewModel = ZWSignInViewModel(input: (username: accountNumberTextFiled.rx.text.orEmpty.asDriver(), password: passWordTextFiled.rx.text.orEmpty.asDriver(), signInTap: loginBtn.rx.tap.asDriver()))
        
        viewModel.signInEnabled
            .drive(onNext: { [weak self] valid in
                self?.loginBtn.alpha = valid ? 1.0 : 0.5
                self?.loginBtn.isEnabled = valid
            })
            .disposed(by: rx.disposeBag)
        
        viewModel.signingIn
            .drive(onNext: { bool in
                bool ? SVProgressHUD.show() : SVProgressHUD.dismiss()
            })
            .disposed(by: rx.disposeBag)
        
        viewModel.signedIn
            .drive(onNext: {[weak self]  bool in
                
                if bool {
                    
                    SVProgressHUD.showSuccess(withStatus: "登录成功")
                    self?.pushTabBarVC()
                    
                }else{
                    SVProgressHUD.showError(withStatus: "登录失败")
                }
            
            })
            .disposed(by: rx.disposeBag)
    }
    
    func pushTabBarVC()  {
        let mainVC = ZWMainTabBarViewController.creatTabBarVC()
        UIApplication.shared.keyWindow?.rootViewController = mainVC
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
