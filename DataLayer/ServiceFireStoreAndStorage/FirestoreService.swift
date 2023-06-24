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
    
    func updateDocument(collection: String, document: String, data: [String : Any]) -> AnyPublisher<[String : Any], Error>{
        
        return Future<[String : Any], Error> { promise in
            let db = Firestore.firestore()
            
            let ref = db.collection(collection).document(document)
            
            ref.updateData(data) { err in
                if let err = err {
                    
                    promise(.failure(err))
                } else {
                    
                    promise(.success(data))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getAllDocument<T: InitializableProtocol>(path: String) -> AnyPublisher<T, Error> {
        let subject = PassthroughSubject<T, Error>()
        
        let db = Firestore.firestore()
        
        db.collection(path).getDocuments() { (querySnapshot, err) in
            if let err = err {
                subject.send(completion: .failure(err))
            } else {
                DispatchQueue.global().async {
                    for document in querySnapshot!.documents {
                        if let doc = T(dictionary: document.data()) {
                            subject.send(doc)
                        } else {
                            print("Cannot convert to PostModel for document: \(document)")
                            continue
                        }
                    }
                    
                    subject.send(completion: .finished)
                }
            }
        }
        return subject.eraseToAnyPublisher()
    }
    
    func getDocumentsWithCondition<T: InitializableProtocol>(collection: String, conditions: [FilterCondition]?, orderBy: String?, decending: Bool? , limit: Int? ) -> AnyPublisher<T, Error> {
        
        let subject = PassthroughSubject<T, Error>()
        
        let db = Firestore.firestore()
        
        var query : Query = db.collection(collection)
        
        if let conditions{
            for condition in conditions {
                let field = condition.field
                let filterOperator = condition.filterOperator
                let value = condition.value

                switch filterOperator {
                case .isEqualTo:
                    query = query.whereField(field, isEqualTo: value)
                case .isGreaterThan:
                    query = query.whereField(field, isGreaterThan: value)
                case .isGreaterThanOrEqualTo:
                    query = query.whereField(field, isGreaterThanOrEqualTo: value)
                case .isLessThan:
                    query = query.whereField(field, isLessThan: value)
                case .isLessThanThanOrEqualTo:
                    query = query.whereField(field, isLessThanOrEqualTo: value)
                case .inQuery:
                    query = query.whereField(field, in: value as! [Any])
                case .notInQuery:
                    query = query.whereField(field, notIn: value as! [Any])
                case .arrayContains:
                    query = query.whereField(field, arrayContains: value)
                case .arrayContainsAny:
                    query = query.whereField(field, arrayContainsAny: value as! [Any])
                }
            }
        }
        
        if let orderBy {
            if let decending {
                query = query.order(by: orderBy, descending: decending)
            }
        }
        
        if let limit {
            query = query.limit(to: limit)
        }
        
        query.getDocuments { (querySnapshot, err) in
            if let err = err {
                subject.send(completion: .failure(err))
            } else {
              
                for document in querySnapshot!.documents {
                    if let doc = T(dictionary: document.data()) {
                        subject.send(doc)
                    } else {
                        print("Cannot convert to PostModel for document: \(document)")
                        continue
                    }
                }
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
//                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    
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


