//
//  EditAvatarViewModel.swift
//  DefaultProject
//
//  Created by daktech on 6/13/23.
//

import Foundation
import UIKit
import Combine

class EditAvatarViewModel {
    
    let firestore : FirestoreProtocol
    let storage: StorageProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(firestore: FirestoreProtocol, storage: StorageProtocol) {
        self.firestore = firestore
        self.storage = storage
    }
    
    func updateImage(uiImage: UIImage, path: String, document: String, param: String, completion: @escaping (String?) -> Void) {
        storage.uploadImage(uiImage: uiImage)
            .flatMap { result -> AnyPublisher<[String : Any], Error> in
                switch result {
                case .failure(_):
                    return Empty().eraseToAnyPublisher()
                case .success(let link):
                    return self.firestore.updateDocument(collection: path, document: document, data: [param : link])
                case .progress(_):
                    return Empty().eraseToAnyPublisher()
                }
            }
            .sink { completion in
                switch completion {
                case .failure(let error):
                    // Handle overall failure
                    print("Error: \(error.localizedDescription)")
                case .finished:
                    print("Request finished")
                }
            } receiveValue: { result in
                let data = result.values.map { String(describing: $0) }
                completion(data.first)
            }
            .store(in: &cancellables)
    }
}
