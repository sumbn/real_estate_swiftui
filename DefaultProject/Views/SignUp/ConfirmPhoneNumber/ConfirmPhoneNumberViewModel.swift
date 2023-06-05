//
//  ConfirmPhoneNumberViewModel.swift
//  AuthenWithFirebases
//
//  Created by daktech on 5/22/23.
//

import Foundation

class ConfirmPhoneNumberViewModel : ObservableObject {
    private let authService: AuthServiceProtocol

    @Published var otpFields: [String] = Array(repeating: "", count: 6)
    
    var verificationCode: String {
        return otpFields.joined()
    }
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func comFirmOTP(authentication: AuthenticationModel, confirmOtpSuccess: @escaping (AuthenticationModel) -> Void){
        
        var authenticationModel = authentication
        authenticationModel.provider = .sms(sendOTP: false, confirmOTP: true)
        authenticationModel.user?.verificationCode = self.verificationCode
        authService.signIn(with: authenticationModel) { result in
            switch (result){
                
            case .success(let auth):
                confirmOtpSuccess(auth)
                print("Confirm OTP thành công (ForgetPasswordViewModel): \(auth.user?.phoneNumber)")
                break
                
            case .failure(let error):
                print("Confirm OTP Thất Bại(ForgetPasswordViewModel): \(error.localizedDescription)")
                break
            }
            
        }
    }
}
