//
//  ZWSignInViewModel.swift
//  rxSwiftDemo
//
//  Created by zzw on 2018/3/30.
//  Copyright © 2018年 zzw. All rights reserved.
//

import RxCocoa
import RxSwift

enum ValidationResult {
    case ok(message:String)
    case empty
    case validating
    case failed(message:String)
}

extension ValidationResult{
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
        
    }
    
}

class ZWSignInViewModel {
    
    let validatedUsername:Driver<ValidationResult>
    let validatedPassword:Driver<ValidationResult>
    let validaredPasswordRepeated:Driver<ValidationResult>
    
    let signInEnabled :Driver<Bool>
    
    let signedIn:Driver<Bool>
    
    let signingIn:Driver<Bool>
    
    init(input:(username:Driver<String>,password:Driver<String>)) {
        
        validatedUsername = input.username.map({ (username)  in
            return Variable( username.count > 5)
           
        })
    }
    
}
