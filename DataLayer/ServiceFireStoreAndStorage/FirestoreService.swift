//
//  FirestoreService.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/30/23.
//

import Foundation
import FirebaseFirestore

class FirestoreService : FirestoreProtocol {
    
    
    func addDocument(_ post: PostModel, completion: @escaping (Result<String, Error>) -> Void) {
        
        
        
        let db = Firestore.firestore()
        
        db.collection("DanhMuc/CanHoChungCu/ChoThue").document(post.id).setData(post.toDictionary()) { (error) in
            if let error = error {
                print("Lỗi khi lưu bài đăng vào Firestore: \(error.localizedDescription)")
            } else {
                print("Bài đăng đã được lưu thành công vào Firestore")
                completion(.success("sucess"))
            }
        }
    }
    
    func getAllDocument(completion: @escaping (Result<[PostModel], Error>) -> Void) {
        let db = Firestore.firestore()
        db.collection("DanhMuc/CanHoChungCu/ChoThue").getDocuments() { (querySnapshot, err) in
            var listPost = [PostModel]()
            
            if let err = err {
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    if let postModel = PostModel(dictionary: document.data()) {
                        listPost.append(postModel)
                    } else {
                        print("Cannot convert to PostModel for document: \(document)")
                                continue
                    }
                    
                }
            }
            
            completion(.success(listPost))
        }
        
        
    }
}
