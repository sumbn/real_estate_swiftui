//
//  GetAllPostViewModel.swift
//  AuthenWithFirebase
//
//  Created by daktech on 6/3/23.
//

import Foundation
import Combine
import SwiftUI

class GetAllPostViewModel : ObservableObject {
    
    let fireStoreService: FirestoreProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published var list = [PostModel]()
    
    init(fireStoreService: FirestoreProtocol) {
        self.fireStoreService = fireStoreService
    }
    
    func getAllData() {
        let service : AnyPublisher<PostModel, Error> = fireStoreService.getAllDocument(path: Constants.pathDocument)
        
        service
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] element in
                withAnimation(.easeInOut) {
                    self?.list.append(element)
                }
            }
            .store(in: &cancellables)
    }
}
