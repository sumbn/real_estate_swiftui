//
//  GetAllPostViewModel.swift
//  AuthenWithFirebase
//
//  Created by daktech on 6/3/23.
//

import Foundation

class GetAllPostViewModel {
    let fireStoreService : FirestoreProtocol
    init(fireStoreService: FirestoreProtocol) {
        self.fireStoreService = fireStoreService
    }
    
    func getAllData(completion: @escaping (Result<[PostModel], Error>) -> Void){
        
        fireStoreService.getAllDocument { result in
            switch result {
            case .success(let list):
                completion(.success(list))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
