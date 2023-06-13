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
    
    func addDocument(path: String, id: String,_ post: [String : Any]) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            let db = Firestore.firestore()
            
            db.collection(path).document(id).setData(post) { error in
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
    
    func getAllDocument(path: String) -> AnyPublisher<[PostModel], Error> {
        let subject = PassthroughSubject<[PostModel], Error>()
        
        let db = Firestore.firestore()
        
        db.collection(path).getDocuments() { (querySnapshot, err) in
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
    
    func checkExistOfDocument(path: String, _ document: String) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { promise in
            
            let db = Firestore.firestore()
            let docRef = db.collection(path).document(document)

            docRef.getDocument { (document, error) in
                if let error {
                    promise(.failure(error))
                }
                
                if let document = document, document.exists {
//                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                    print("Document data: \(dataDescription)")
                    promise(.success(true))
                } else {
                    print("Document does not exist")
                    promise(.success(false))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    
}
