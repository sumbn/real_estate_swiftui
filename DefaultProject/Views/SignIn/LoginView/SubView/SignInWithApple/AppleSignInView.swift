//
//  AppleSignInView.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/11/23.
//

import SwiftUI
import AuthenticationServices

struct AppleSignInView: View {
    
    @ObservedObject var appleViewModel : AppleSignInViewModel
    let completion: (AuthenticationResult) -> Void
    
    init(completion: @escaping (AuthenticationResult) -> Void) {
        self.completion = completion
        let appleService = AppleAuthService()
        let authenService = AuthService(signInService: appleService)
        self.appleViewModel = AppleSignInViewModel(authService: authenService)
    }
    
    var body: some View {
        
        Button {
            appleViewModel.signInWithApple { result in
                switch result{
                case .success(let auth):
                    completion(.success(auth))
                case .failure(let err):
                    completion(.failure(err))
                }
            }
        } label: {
            Image("apple")
                .resizable()
                .scaledToFit()
                .frame(height: 40)
        }
    }
}

extension UIViewController: ASAuthorizationControllerPresentationContextProviding{
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}


struct AppleSignInView_Previews: PreviewProvider {
    static var previews: some View {
        AppleSignInView{ result in
            
        }
    }
}
