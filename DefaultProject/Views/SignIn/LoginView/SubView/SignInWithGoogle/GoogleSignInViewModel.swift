
//
//  Created by daktech on 5/15/23.
//

import Foundation

import FirebaseAuth


class GoogleSignInViewModel: ObservableObject {
    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func signInWithGoogle(completion: @escaping (AuthenticationResult) -> Void){
        
        var authenticationModel = AuthenticationModel(provider: .google)
        
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



