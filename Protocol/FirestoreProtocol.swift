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
    
    func getAllDocument<T: InitializableProtocol>(path: String) -> AnyPublisher<[T], Error> 
    
    func getDocument<T : InitializableProtocol>(path: String, _ document: String) -> AnyPublisher<ResultGetDocument<T>, Error>
    
    func updateDocument(collection: String, document: String, data: [String : Any]) -> AnyPublisher<[String : Any], Error>
}
