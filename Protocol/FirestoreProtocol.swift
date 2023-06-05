//
//  FirestoreProtocol.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/30/23.
//

import Foundation

protocol FirestoreProtocol {
    func addDocument(_ post: PostModel, completion: @escaping (Result<String, Error>) -> Void)
    
    func getAllDocument(completion: @escaping (Result<[PostModel], Error>) -> Void)
}
