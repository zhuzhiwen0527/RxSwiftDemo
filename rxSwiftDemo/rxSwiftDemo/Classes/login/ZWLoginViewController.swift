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
        bindModel()
    }
    
    
    func createUI()  {
        
       accountNumberTextFiled = UITextField().then {
            $0.textColor = UIColor.black
            $0.placeholder = "输入账号"
            $0.borderStyle = UITextBorderStyle.line
            $0.keyboardType = UIKeyboardType.numberPad
            $0.font = UIFont.systemFont(ofSize: 14)
            view.addSubview($0)
            $0.snp.makeConstraints({
                $0.top.equalTo(view).offset(150)
                $0.left.equalTo(view).offset(30)
                $0.right.equalTo(view).offset(-30)
                $0.height.equalTo(50)
            })
 
        }

        
        
        passWordTextFiled =  UITextField().then {
            $0.textColor = UIColor.black
            $0.placeholder = "输入密码"
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.borderStyle = UITextBorderStyle.line
            view.addSubview($0)
            $0.snp.makeConstraints({
                $0.top.equalTo(accountNumberTextFiled.snp.bottom).offset(20)
                $0.left.right.equalTo(accountNumberTextFiled!)
                $0.height.equalTo(50)
            })
        }
        
        loginBtn = UIButton().then({
            
            $0.setTitle("登录", for: .normal)
            $0.backgroundColor = UIColor.green
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
    
    func bindModel(){
        
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
