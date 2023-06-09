//
//  FacebookSignInViewModel.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/17/23.
//

import Foundation

class FacebookSignInViewModel : ObservableObject {
    
    private let authService : AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func signInWithGoogle(completion: @escaping (AuthenticationResult) -> Void){
        
        var authenticationModel = AuthenticationModel(provider: .facebook)
        
        authService.signIn(with: authenticationModel){ result in
            
            switch(result){
                
            case .success(let authen):
                completion(.success(authen))
                
            case .failure(let error):
                completion(.failure(error))
                
                
            }
        }
        
    }
}
