//
//  ConfirmOTPService.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/16/23.
//

import Foundation
import FirebaseAuth

class ConfirmOTPService : SignInServiceProtocol {
    func signIn(with authentication: AuthenticationModel, completion: @escaping (AuthenticationResult) -> Void) {
        signInWithPhoneNumber(authentication: authentication)(authenticateByPhone(completion: completion, authentication: authentication))
    }
    
    func signInWithPhoneNumber(authentication: AuthenticationModel) -> ((PhoneAuthCredential) -> Void) -> Void {
        return {
            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: authentication.user?.verificationID ?? "111111",
                verificationCode: authentication.user?.verificationCode ?? ""
            )
            print("credential: \(credential)")
            $0(credential)
        }
    }
    
    func authenticateByPhone(completion: @escaping (AuthenticationResult) -> Void, authentication: AuthenticationModel) -> (AuthCredential) -> Void {
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
                
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = authentication.user?.displayName
                
                changeRequest.commitChanges { error in
                    if let error = error {
                        // Xử lý lỗi khi cập nhật displayName
                        print("Lỗi khi cập nhật displayName: \(error.localizedDescription)")
                    } else {
                        
                        var authentication = authentication
                        authentication.user?.uid = user.uid
                        authentication.user?.displayName = user.displayName
                        authentication.user?.photoURL = user.photoURL?.absoluteString
                        
                        completion(.success(authentication))
                        // Cập nhật displayName thành công
                        print("Cập nhật displayName thành công")
                    }
                }
                }
            }
        }
        
    }
