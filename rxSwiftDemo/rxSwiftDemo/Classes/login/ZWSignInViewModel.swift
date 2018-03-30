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


class ZWSignInViewModel {
    
    let validatedUsername:Driver<ValidationResult>
    let validatedPassword:Driver<ValidationResult>

//
//    let signInEnabled :Driver<Bool>
//
//    let signedIn:Driver<Bool>
//
//    let signingIn:Driver<Bool>
    
    init(input:(username:Driver<String>,password:Driver<String>)) {
        
        
        validatedUsername = input.username.map({ usernameString  in
            
            let usernameRule = ValidationRuleLength(min: 5, max: 20, failureError: ValidationError(message:"InValid Username"))
            return usernameString.validate(rule: usernameRule)
        })
        
        validatedPassword = input.password.map({ passwd in
            let passwdRule = ValidationRuleLength(min: 5, max: 20, failureError: ValidationError(message:"InValid Username"))
            return passwd.validate(rule: passwdRule)
        })
        
    }

    
}

