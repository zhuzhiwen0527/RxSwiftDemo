//
//  ZWSignInViewModel.swift
//  rxSwiftDemo
//
//  Created by zzw on 2018/3/30.
//  Copyright © 2018年 zzw. All rights reserved.
//

import RxCocoa
import RxSwift
import Validator
import SVProgressHUD

class ZWSignInViewModel {
    
    let validatedUsername:Driver<ValidationResult>
    let validatedPassword:Driver<ValidationResult>


    let signInEnabled :Driver<Bool>

    let signedIn:Driver<Bool>

    let signingIn:Driver<Bool>
    
    init(input:(username:Driver<String>,password:Driver<String>,signInTap: Driver<Void>)) {
        
        
        validatedUsername = input.username.map({ usernameString  in
            print("验证手机号码")
            
            let phoneNumberValidationPattern = ValidationPattern.PhoneNumber
            
            let usernameRule = ValidationRulePattern(pattern: phoneNumberValidationPattern, failureError: ValidationError(message:"InValid Username"))
            
            return usernameString.validate(rule: usernameRule)
        })
        
        validatedPassword = input.password.map({ passwd in
            print("验证密码")
            let passwdRule = ValidationRuleLength(min: 6, max: 20, failureError: ValidationError(message:"InValid Username"))
            return passwd.validate(rule: passwdRule)
        })
        
        let signInIndicator  = ActivityIndicator()
        
        signingIn = signInIndicator.asDriver()
        //判断是否账号密码 是否合法 是否正在请求网络
        signInEnabled = Driver.combineLatest(validatedUsername, validatedPassword,self.signingIn){username,password,signingIn in
          
   
            return username.isValid && password.isValid && !signingIn
        }
        
        //合并
        let usernameAndPassword = Driver.combineLatest(input.username, input.password) { ($0,$1)}
        
        signedIn = input.signInTap.withLatestFrom(usernameAndPassword).flatMapLatest({ (event) in
            
            print(event)
            
            return zwNetTool.rx.request(.user(username:event.0,password:event.1)).asObservable().mapObject(userModel.self).trackActivity(signInIndicator).map({model in
                print("返回数据")
                return model.code
            }).asDriver(onErrorJustReturn: false)

        })
        
        
    }

    
}

