
//
//  Created by daktech on 5/16/23.
//

import Foundation

class ForgetPasswordViewModel : ObservableObject {
    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func sendOtpToPhoneNumber(phoneNumber: String, sendOtpSuccess: @escaping (AuthenticationModel) -> Void){
        
        var authenticationModel = AuthenticationModel(provider: .sms(sendOTP: true, confirmOTP: false), user: UserModel(uid: "", displayName: nil, email: nil, photoURL: nil, phoneNumber: phoneNumber))
        
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
