//
//  GoogleAuthService.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/15/23.
//

import Foundation
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

class GoogleAuthService: BaseService, SignInServiceProtocol {
    
    func signIn(with authentication: AuthenticationModel, completion: @escaping (AuthenticationResult) -> Void) {
        getCredential(completion: completion)(authenticate(completion: completion, authentication: authentication))
        
    }
    
    func getCredential(completion: @escaping (AuthenticationResult) -> Void) -> (@escaping (AuthCredential) -> Void) -> Void {
        return { authCompletion in
            //get app client id
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            
            // Create Google Sign In configuration object.
            let config = GIDConfiguration(clientID: clientID)
            
            GIDSignIn.sharedInstance.configuration = config
            
            // Start the sign in flow!
            GIDSignIn.sharedInstance.signIn(withPresenting: Utilities.shared.rootViewController()!) { result, error in
                guard error == nil else { return }
                
                guard let user = result?.user,
                      let idToken = user.idToken?.tokenString
                else {
                    let error = NSError(domain: "com.yourapp.error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get user information from Google."])
                    completion(.failure(error))
                    return
                    
                }
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                               accessToken: user.accessToken.tokenString)
                authCompletion(credential)
            }
        }
    }
    
}

