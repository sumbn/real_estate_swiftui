//
//  BaseService.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/17/23.
//

import Foundation
import FirebaseAuth


class BaseService {
    
    func authenticate(completion: @escaping (AuthenticationResult) -> Void, authentication: AuthenticationModel) -> (AuthCredential) -> Void {
        return {
            Auth.auth().signIn(with: $0) { result, error in
                if let err = error {
                    completion(.failure(err))
                    print(err.localizedDescription)
                    return
                }
                
                guard let user = result?.user else {
                    let error = error ?? NSError(domain: "com.yourapp.error", code: 0, userInfo: [NSLocalizedDescriptionKey: "User object is nil."])
                    completion(.failure(error))
                    return
                }
                
                var authentication = authentication
                authentication.user = UserModel(uid: user.uid, displayName: user.displayName, email: user.email, photoURL: user.photoURL)
                
                completion(.success(authentication))
            }
        }
    }
}
