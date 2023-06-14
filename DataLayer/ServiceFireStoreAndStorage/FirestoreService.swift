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
    
    func updateDocument(collection: String, document: String, data: [String : Any]) -> AnyPublisher<String, Error>{
        
        return Future<String, Error> { promise in
            let db = Firestore.firestore()
            
            let ref = db.collection(collection).document(document)
            
            ref.updateData(data) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                    promise(.failure(err))
                } else {
                    
                    if let identifier = data.values.first {
//                        print("\(String(describing: identifier) as String)")
                        
                        promise(.success((String(describing: identifier) as String)))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getAllDocument<T: InitializableProtocol>(path: String) -> AnyPublisher<[T], Error> {
        let subject = PassthroughSubject<[T], Error>()
        
        let db = Firestore.firestore()
        
        db.collection(path).getDocuments() { (querySnapshot, err) in
            if let err = err {
                subject.send(completion: .failure(err))
            } else {
                var listDocument = [T]()
                for document in querySnapshot!.documents {
                    if let doc = T(dictionary: document.data()) {
                        listDocument.append(doc)
                    } else {
                        print("Cannot convert to PostModel for document: \(document)")
                        continue
                    }
                }
                subject.send(listDocument)
                subject.send(completion: .finished)
            }
        }
        return subject.eraseToAnyPublisher()
    }
    
    func getDocument<T : InitializableProtocol>(path: String, _ document: String) -> AnyPublisher<ResultGetDocument<T>, Error> {
        return Future<ResultGetDocument, Error> { promise in
            
            let db = Firestore.firestore()
            let docRef = db.collection(path).document(document)
            
            docRef.getDocument { (document, error) in
                if let error {
                    promise(.failure(error))
                }
                
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                    
                    promise(.success(.success(T(dictionary: document.data() ?? ["lỗi":"không thể ép kiểu sang"])!)))
                } else {
                    
                    let error = NSError(domain: "FirestoreService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Document không tồn tại"])
                    print("Document does not exist")
                    promise(.success(.failure(error)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

enum ResultGetDocument <T> {
    case success(T)
    case failure(Error)
}

