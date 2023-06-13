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
    
    init(fireStore: FirestoreProtocol){
        self.fireStore = fireStore
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    let fireStore : FirestoreProtocol

    @Published var userSession : AuthenticationModel?
    {
        willSet(newValue){
            if newValue?.user?.uid != userSession?.user?.uid {
                guard let uid = newValue?.user?.uid else { return }
                let account = AccountModel(uid: uid, image: "", name: newValue?.user?.displayName ?? "", address: AddressModel(province: "", district: "", commune: "", specific: ""), phoneNumber: "", bio: "", identify: IDModel(no: "", dateOfIssued: "", issuedBy: ""), gender: "", dayOfBirth: "")
                
                fireStore.checkExistOfDocument(path: Constants.pathAccount, uid)
                    .flatMap { documentExists in
                        if documentExists {
                            print("đã có tài khoản")
                            return Empty<Void, Error>().eraseToAnyPublisher()
                        } else {
                            return self.fireStore.addDocument(path: Constants.pathAccount, id: uid, account.toDictionary())
                        }
                    }
                    .sink { completion in
                           switch completion {
                           case .failure(let error):
                               print("Error: \(error.localizedDescription)")
                           case .finished:
                               print("Request finished")
                           }
                       } receiveValue: { _ in
                           print("Success")
                       }
                       .store(in: &cancellables)
            }
        }
    }
    
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
