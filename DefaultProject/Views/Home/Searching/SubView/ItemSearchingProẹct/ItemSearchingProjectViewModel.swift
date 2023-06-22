//
//  ItemSearchingProjectViewModel.swift
//  DefaultProject
//
//  Created by daktech on 6/22/23.
//

import Foundation
import Combine

class ItemSearchingProjectViewModel : ObservableObject {
    let fireStore : FirestoreProtocol
    init(fireStore: FirestoreProtocol) {
        self.fireStore = fireStore
    }
    
    var cancellable : Set<AnyCancellable> = []
    
    @Published var nameUser : String = ""
    
    func getNameUserFromPosting(uid: String){
        let getAccount : AnyPublisher<ResultGetDocument<AccountModel>, Error> = fireStore.getDocument(path: Constants.pathAccount, uid)
        getAccount
            .sink { completion in
                
            } receiveValue: { result in
                switch result {
                case .failure(let err):
                    print(err)
                case .success(let account):
                    print(account.name)
                    self.nameUser = account.name ?? ""
                }
            }
            .store(in: &cancellable)
    }
    
    
}
