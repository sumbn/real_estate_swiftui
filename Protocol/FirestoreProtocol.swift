//
//  FirestoreProtocol.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/30/23.
//

import Foundation
import Combine

protocol FirestoreProtocol {
    
    func addDocument(_ post: PostModel) -> AnyPublisher<Void, Error>
    
    func getAllDocument() -> AnyPublisher<[PostModel], Error>
}