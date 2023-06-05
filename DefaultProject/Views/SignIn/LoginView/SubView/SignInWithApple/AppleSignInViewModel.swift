//
//  AppleSignInViewModel.swift
//  AuthenWithFirebases
//
//  Created by daktech on 5/19/23.
//

import Foundation
import AuthenticationServices



class AppleSignInViewModel : ObservableObject {
    
    private let authService: AuthServiceProtocol
     
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func signInWithApple(completion: @escaping (AuthenticationResult) -> Void) {
        let authenModel = AuthenticationModel(provider: .apple)
        authService.signIn(with: authenModel) { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}




