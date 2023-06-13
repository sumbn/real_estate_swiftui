//
//  FirestoreProtocol.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/30/23.
//

import Foundation
import Combine

protocol FirestoreProtocol {
    
    func addDocument(path: String, id: String,_ post: [String : Any]) -> AnyPublisher<Void, Error>
    
    func getAllDocument(path: String) -> AnyPublisher<[PostModel], Error>
    
    func checkExistOfDocument(path: String, _ document: String) -> AnyPublisher<Bool, Error>
}
