//
//  EditInfomationViewModel.swift
//  DefaultProject
//
//  Created by daktech on 6/12/23.
//

import Foundation
import UIKit
import Combine

class EditInfomationViewModel {
    
    let storageService : StorageProtocol
    let firestoreService : FirestoreProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    init(storageService: StorageProtocol, firestoreService: FirestoreProtocol) {
        self.storageService = storageService
        self.firestoreService = firestoreService
    }
    
    func createNodeFireStore(uiImage : UIImage?){
        
        if let uiImage {
            storageService.uploadImage(uiImage: uiImage)
                .sink { result in
                    
                } receiveValue: { result in
                    switch result {
                    case .success(_): break
                    case .failure(_): break
                    case .progress(_): break
//                        self.progress = double / 100
                    }
                }
                .store(in: &cancellables)
        }
    }
    
    func updateDataFireStore(uid: String, data: AccountModel, completion: @escaping (AccountModel)->Void){
        firestoreService.updateDocument(collection: Constants.pathAccount, document: uid, data: data.toDictionary())
            .sink { result in
                
            } receiveValue: { result in
//               print(AccountModel(dictionary: result))
                completion(AccountModel(dictionary: result)!)
            }
            .store(in: &cancellables)
    }
    
    func getData(collection: String, document: String, completion: @escaping (AccountModel) -> Void){
        let account : AnyPublisher<ResultGetDocument<AccountModel>, Error> = firestoreService.getDocument(path: collection, document)
        account.sink { completion in
            
        } receiveValue: { result in
            switch result {
            case .success(let account):
                completion(account)
            case .failure(_): break
            }
        }
        .store(in: &cancellables)

    }
}
