//
//  SignInServiceProtocol.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/15/23.
//

import Foundation

protocol SignInServiceProtocol {
    func signIn(with authentication: AuthenticationModel, completion: @escaping (AuthenticationResult) -> Void)
}
