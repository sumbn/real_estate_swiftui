//
//  FacebookAuthService.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/17/23.
//

import Foundation
import FBSDKLoginKit
import FirebaseAuth
import CryptoKit

class FacebookAuthService : BaseService, SignInServiceProtocol {
    
    func signIn(with authentication: AuthenticationModel, completion: @escaping (AuthenticationResult) -> Void) {
        getCredential(completion: completion)(authenticate(completion: completion, authentication: authentication))
        
    }
    
    func getCredential(completion: @escaping (AuthenticationResult) -> Void) -> (@escaping (AuthCredential) -> Void) -> Void {
        return { authen in
            let fbLoginManager = LoginManager()
            fbLoginManager.logIn(permissions: ["public_profile", "email"], from: nil) { (result, error) in
                if let error = error {
                    completion(.failure(error))
                } else if result?.isCancelled == true {
                    
                    completion(.failure(NSError(domain: "com.yourapp.error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Facebook deny access"])))
                } else {
                    let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                    authen(credential)
                }
            }
        }
    }
}
