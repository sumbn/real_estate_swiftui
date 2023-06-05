//
//  UserModel.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/15/23.
//

import Foundation

struct UserModel {
    var uid: String
    var displayName: String?
    var email: String?
    var photoURL: URL?
    var phoneNumber: String? = nil
    var verificationCode: String? = nil
    var verificationID : String? = nil
}
