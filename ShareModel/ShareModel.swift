//
//  CoordinatorFactoryProtocol.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/18/23.
//

import Foundation
import SwiftUI
import FirebaseAuth

//@MainActor
//final class Coordinator: ObservableObject{
//
//    @Published var path = NavigationPath()
//    @Published var page: Page = .home
//    @Published var sheet: Sheet?
//    @Published var fullScreenCover : FullScreenCover?
//    @Published var userSession : AuthenticationModel?
//    @Published var isAuth = false
//
//    func push(_ page: Page){
//        path.append(page)
//    }
//
//    func push(_ page: Page, authenticationModel: AuthenticationModel){
//        userSession = authenticationModel
//        path.append(page)
//    }
//
//    func present(_ sheet : Sheet){
//        self.sheet = sheet
//    }
//
//    func present(_ fullScreenCover: FullScreenCover) {
//        self.fullScreenCover = fullScreenCover
//    }
//
//    func pop(){
//        path.removeLast()
//    }
//
//    func popToRoot(){
//        path.removeLast(path.count)
//    }
//
//    func dissmissSheet(){
//        self.sheet = nil
//    }
//
//    func dissmissFullScreenCover(){
//        self.fullScreenCover = nil
//    }
//
//
//    //MARK: View providers
//    @ViewBuilder
//    func build(_ page: Page) -> some View {
//        switch page{
//        case .home:
//            HomeView()
//        case .confirmPass:
//            PhoneVerificationView()
//        }
//    }
//
//    @ViewBuilder
//    func build(_ sheet: Sheet) -> some View{
//        switch sheet {
//        case .signUp:
//            SignUpView()
//
//        }
//    }
//
//    @ViewBuilder
//    func build(_ fullScreenCover: FullScreenCover) -> some View{
//        switch fullScreenCover {
//        case .login:
//            LoginView()
////        case .forgetPass:
////            ForgetPasswordView()
////        case .confirmPass:
////            PhoneVerificationView()
//        }
//
//    }
//}
//
//enum Page: String, Identifiable {
//    case home, confirmPass
//
//    var id: String{
//        self.rawValue
//    }
//}
//
//enum Sheet: String, Identifiable{
//    case signUp
//
//    var id: String{
//        self.rawValue
//    }
//}
//
//enum FullScreenCover: String, Identifiable {
//    case login
////    , forgetPass, confirmPass
//
//    var id: String {
//        self.rawValue
//    }
//}
//


final class ShareModel: ObservableObject{
//
    @Published var userSession : AuthenticationModel?
    @Published var isNotAuth : Bool = true
//
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
