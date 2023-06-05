//
//  FacebookSignInView.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/11/23.
//

import SwiftUI
import FBSDKLoginKit

struct FacebookSignInView: View {
    
    @ObservedObject private var viewModel : FacebookSignInViewModel
    let completion: (AuthenticationResult) -> Void
    
    init(completion: @escaping (AuthenticationResult) -> Void) {
        self.completion = completion
        let facebookAuthService = FacebookAuthService()
        self.viewModel = FacebookSignInViewModel(authService: AuthService(signInService: facebookAuthService))
    }
    
    var body: some View {
        
        Button {
            viewModel.signInWithGoogle {
                switch $0 {
                case .success(let auth):
                    completion(.success(auth))
                case .failure(let err):
                    completion(.failure(err))
                }
            }
            
        } label: {
            Image("facebook")
                .resizable()
                .scaledToFit()
                .frame(height: 40)
        }
        
    }
}


struct FacebookSignInView_Previews: PreviewProvider {
    static var previews: some View {
        FacebookSignInView{result in
            
        }
    }
}


