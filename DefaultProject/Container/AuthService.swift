
//
//  Created by daktech on 5/15/23.
//

import Foundation



class AuthService : AuthServiceProtocol{
    
    private let signInService: SignInServiceProtocol
    
    
    init(signInService: SignInServiceProtocol) {
        self.signInService = signInService
    }
    
    func signIn(with authentication: AuthenticationModel, completion: @escaping (AuthenticationResult) -> Void) {
        print("AuthService \(authentication.user?.verificationCode)")
        switch authentication.provider {
        case .google:
            print("Login with Google (AuthService)")
            // Xử lý đăng nhập bằng Google
            signInService.signIn(with: authentication){ result in
                switch result {
                case .success(let auth):
                    completion(.success(auth))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        case .facebook:
            print("Login with Facebook (AuthService)")
            signInService.signIn(with: authentication) { result in
                switch result {
                case .success(let auth):
                    completion(.success(auth))
                case .failure(let err):
                    completion(.failure(err))
                }
            }
            
        case .apple:
            print("Login with Apple (AuthService)")
            signInService.signIn(with: authentication) { result in
                switch result{
                case .success(let auth):
                    completion(.success(auth))
                case .failure(let err):
                    completion(.failure(err))
                }
            }
            
        case .sms(let sendOTP, let confirmOTP):
            if sendOTP {
                signInService.signIn(with: authentication) { result in
                    switch result {
                    case .success(let auth):
                        completion(.success(auth))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
            
            if confirmOTP {
                signInService.signIn(with: authentication) { result in
                    switch result {
                    case .success(let authenticatedUser):
                        completion(.success(authenticatedUser))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
            print("Login with SMS (AuthService)")
        case .undefined:
            print("undefined")
        }
    }
}
