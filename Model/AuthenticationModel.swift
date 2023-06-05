//
//  AuthenticationModel.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/15/23.
//

import Foundation
import GoogleSignIn

struct AuthenticationModel {
    var provider: AuthenticationProvider
    var user: UserModel? = nil
}

enum AuthenticationProvider {
    case google
    case facebook
    case apple
    case sms(sendOTP: Bool, confirmOTP: Bool)
    case undefined
}
