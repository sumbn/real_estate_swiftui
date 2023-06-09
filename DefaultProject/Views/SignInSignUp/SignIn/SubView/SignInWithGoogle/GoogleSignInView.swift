//
//  GoogleSignInView.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/11/23.
//

import SwiftUI

struct GoogleSignInView: View {
    
    @ObservedObject private var signInViewModel: GoogleSignInViewModel
    let completion: (AuthenticationResult) -> Void
    
    init(completion: @escaping (AuthenticationResult) -> Void) {
        self.completion = completion
        let googleAuthService = AuthService(signInService: GoogleAuthService())
        signInViewModel = GoogleSignInViewModel(authService: googleAuthService)
    }
    
    var body: some View {
        
        Button {
            signInViewModel.signInWithGoogle{
                switch $0{
                case .success(let auth):
                    completion(.success(auth))
                case .failure(let err):
                    completion(.failure(err))
                }
            }
        } label: {
            Image("google")
                .resizable()
                .scaledToFit()
                .frame(height: 40)
        }
        
    }
        
}

struct GoogleSignInView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSignInView{ result in
            
        }
    }
}
