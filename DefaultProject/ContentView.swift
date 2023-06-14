//
//  ContentView.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/10/23.
//

import SwiftUI
import FirebaseAuth



struct ContentView: View {
    @StateObject var shareModel: ShareModel = .init()
    var body: some View {
        
        VStack {
            MainView()
        }
        .fullScreenCover(isPresented: $shareModel.isNotAuth) {
            LoginView()
        }
        .environmentObject(shareModel)
        .onAppear{
            if let user = Auth.auth().currentUser {
                shareModel.isNotAuth = false
                shareModel.userSession = AuthenticationModel(provider: .undefined)
                shareModel.userSession?.user = UserModel(uid: user.uid, displayName: user.displayName, phoneNumber: user.phoneNumber)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

