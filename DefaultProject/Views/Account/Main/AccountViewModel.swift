//
//  AccountViewModel.swift
//  DefaultProject
//
//  Created by daktech on 6/14/23.
//

import Foundation
import Combine

class AccountViewModel {
    
    let fireStore : FirestoreProtocol
    let storage : StorageProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(fireStore: FirestoreProtocol, storage: StorageProtocol) {
        self.fireStore = fireStore
        self.storage = storage
    }
    
    func getAccountOrCreate(uid: String, getUser: @escaping (AccountModel) -> Void ) {
        
        let account = AccountModel(uid: uid, image: "", name: "", province: "", district: "", commune: "", specific: "", noId: "", dateOfIssued: "", issuedBy: "", phoneNumber: "", bio: "", gender: "", dayOfBirth: "")
        
        let result : AnyPublisher<ResultGetDocument<AccountModel>, Error> = fireStore.getDocument(path: Constants.pathAccount, uid)
        result.flatMap { result in
            switch result {
            case .success(let accountModel):
                getUser(accountModel)
//                print(accountModel)
                return Empty<Void, Error>().eraseToAnyPublisher()
            case .failure(_):
                print("chưa có tài khoản, tạo tài khoản")
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
