//
//  CoordinatorFactoryProtocol.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/18/23.
//

import Foundation
import SwiftUI
import FirebaseAuth
import Combine


final class ShareModel: ObservableObject{
    
    @Published var userSession : AuthenticationModel?
    @Published var isNotAuth : Bool = true
}


//final class ShareModel: ObservableObject {
//    @Published var userSession: AuthenticationModel?
//    @Published var isNotAuth: Bool = true
//
//    private var handle: AuthStateDidChangeListenerHandle?
//
//    init() {
//        handle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
//            guard let self = self else { return }
//
//            if let user = user {
//                DispatchQueue.main.async {
//                    self.isNotAuth = false
//                    self.userSession?.user?.uid = user.uid
//                    self.userSession?.user?.displayName = user.displayName
//                }
//            } else {
//                DispatchQueue.main.async {
//                    self.isNotAuth = true
//                    self.userSession = nil
//                }
//            }
//        }
//    }
//
//    deinit {
//        if let handle = handle {
//            Auth.auth().removeStateDidChangeListener(handle)
//        }
//    }
//}
