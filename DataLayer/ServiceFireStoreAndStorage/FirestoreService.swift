//
//  FirestoreService.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/30/23.
//

import Foundation
import FirebaseFirestore
import Combine

class FirestoreService : FirestoreProtocol {
    
    func addDocument(_ post: PostModel) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            let db = Firestore.firestore()
            
            db.collection("DanhMuc/CanHoChungCu/MuaBan").document(post.id).setData(post.toDictionary()) { error in
                if let error = error {
                    print("Lỗi khi lưu bài đăng vào Firestore: \(error.localizedDescription)")
                    promise(.failure(error))
                } else {
                    print("Bài đăng đã được lưu thành công vào Firestore")
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getAllDocument() -> AnyPublisher<[PostModel], Error> {
        let subject = PassthroughSubject<[PostModel], Error>()
        
        let db = Firestore.firestore()
        
        db.collection("DanhMuc/CanHoChungCu/MuaBan").getDocuments() { (querySnapshot, err) in
            if let err = err {
                subject.send(completion: .failure(err))
            } else {
                var listPost = [PostModel]()
                for document in querySnapshot!.documents {
                    if let postModel = PostModel(dictionary: document.data()) {
                        listPost.append(postModel)
                    } else {
                        print("Cannot convert to PostModel for document: \(document)")
                        continue
                    }
                }
                subject.send(listPost)
                subject.send(completion: .finished)
            }
        }
        
        return subject.eraseToAnyPublisher()
    }
}
