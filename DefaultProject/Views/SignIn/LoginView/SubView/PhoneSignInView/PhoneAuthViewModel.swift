//
//  PhoneAuthViewModel.swift
//  DefaultProject
//
//  Created by daktech on 6/8/23.
//

import Foundation
class PhoneAuthViewModel : ObservableObject {
    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func sendOtpToPhoneNumber(phoneNumber: String, name: String, sendOtpSuccess: @escaping (AuthenticationModel) -> Void){
        
        var authenticationModel = AuthenticationModel(provider: .sms(sendOTP: true, confirmOTP: false), user: UserModel(uid: "", displayName: name, email: nil, photoURL: nil, phoneNumber: phoneNumber))
        
        authService.signIn(with: authenticationModel) { result in
            
            switch (result){
                
            case .success(let auth):
                sendOtpSuccess(auth)
                
                print("Send Otp thành công (ForgetPasswordViewModel): \(auth)")
                break
                
            case .failure(let error):
                print("Send Otp Thất Bại(ForgetPasswordViewModel): \(error.localizedDescription)")
                break
            }
            
        }
    }
}
