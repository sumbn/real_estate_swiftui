//
//  EditInfomationViewModel.swift
//  DefaultProject
//
//  Created by daktech on 6/12/23.
//

import Foundation
import UIKit
import Combine

class EditInfomationViewModel : ObservableObject {
    
    @Published var progress : Double = 0.0
    
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
                    case .progress(let double):
                        self.progress = double / 100
                    }
                }
                .store(in: &cancellables)
        }
    }
}
