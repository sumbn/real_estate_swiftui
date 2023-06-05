//
//  DependencyContainer.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/30/23.
//

import Foundation

class DependencyContainer{
    let firestoreService: FirestoreProtocol
    let storageService: StorageProtocol
    
    init() {
        // Khởi tạo instance của các service
        self.firestoreService = FirestoreService()
        self.storageService = StorageService()
    }
}
