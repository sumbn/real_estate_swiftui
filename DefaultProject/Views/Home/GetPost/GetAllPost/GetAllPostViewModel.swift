//
//  GetAllPostViewModel.swift
//  AuthenWithFirebase
//
//  Created by daktech on 6/3/23.
//

import Foundation
import Combine

class GetAllPostViewModel : ObservableObject {
    
    let fireStoreService: FirestoreProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published var list = [PostModel]()
    
    init(fireStoreService: FirestoreProtocol) {
        self.fireStoreService = fireStoreService
    }
    
    func getAllData() {
        fireStoreService.getAllDocument(path: Constants.pathDocument)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] list in
                self?.list = list
            }
            .store(in: &cancellables)
    }
}
