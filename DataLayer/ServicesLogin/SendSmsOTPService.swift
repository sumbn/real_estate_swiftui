//
//  SendSmsOTPService.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/16/23.
//

import Foundation
import FirebaseAuth

class SendSmsOTPService : SignInServiceProtocol {
    
    func signIn(with authentication: AuthenticationModel, completion: @escaping (AuthenticationResult) -> Void) {
        Auth.auth().languageCode = "vn"
        
        UserDefaults.standard.set(authentication.user?.displayName, forKey: "displayName")
        
//        UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(authentication.user?.phoneNumber ?? "+1 650-555-1111", uiDelegate: nil) { verificationID, error in
                
                guard error == nil else {
                    completion(.failure(error!))
                    return }
                
                var authen = authentication
                authen.user?.verificationID = verificationID
                
                completion(.success(authen))
                print("verificatioID (SendSmsOTPService) : \(String(describing: verificationID))")
            }
    }
}
