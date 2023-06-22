//
//  SearchingProjectViewModel.swift
//  DefaultProject
//
//  Created by daktech on 6/19/23.
//

import Foundation
import Combine
import SwiftUI
import FirebaseFirestore

class SearchingProjectViewModel : ObservableObject {
    
    var cancellable : Set<AnyCancellable> = []
    
    let firestore : FirestoreProtocol
    init(firestore: FirestoreProtocol) {
        self.firestore = firestore
    }
    
    var listProvince : [Province] {
        let list = Bundle.main.decode(type: [Province].self, from: "fakeJson.json")
        return list
    }
    
    @Published var listSearchedItem = [PostModel]()
    
    func filterData(filter: [FilterCondition], orderBy: String?, decending: Bool?, limit: Int?){
        
        withAnimation {
            listSearchedItem.removeAll()
        }
        
        let test : AnyPublisher<PostModel, Error> = firestore.getDocumentsWithCondition(collection: Constants.pathDocument, conditions: filter, orderBy: orderBy, decending: decending, limit: limit)
        
        test
            .sink { completion in
                
            } receiveValue: { post in
                print(post)
                withAnimation {
                    self.listSearchedItem.append(post)
                }
            }
            .store(in: &cancellable)
        
    }
    
    func testImplement(){
        
//        let db = Firestore.firestore()
//        db.collection(Constants.pathDocument).whereField("imageURLs", arrayContains: "https://firebasestorage.googleapis.com:443/v0/b/fir-authentication-7b6d9.appspot.com/o/images%2F20230621111455734666A0-D8E5-432C-BC38-BD896AD8D719.jpg?alt=media&token=ce27bf14-6a0f-4c3c-b99a-1ee9acd5c7d8").getDocuments { snap, err in
//            guard let documents = snap?.documents else { return }
//            print(documents)
//        }
        
        let fiter = FilterCondition(field: "imageURLs", filterOperator: .arrayContains, value: "https://firebasestorage.googleapis.com:443/v0/b/fir-authentication-7b6d9.appspot.com/o/images%2F20230621111455734666A0-D8E5-432C-BC38-BD896AD8D719.jpg?alt=media&token=ce27bf14-6a0f-4c3c-b99a-1ee9acd5c7d8")
        
        let fiter2 = FilterCondition(field: "province_city", filterOperator: .isEqualTo, value: "ha")
        
        let test : AnyPublisher<PostModel, Error> = firestore.getDocumentsWithCondition(collection: Constants.pathDocument, conditions: [fiter2], orderBy: nil, decending: nil, limit: nil)
        
        test
            .sink { completion in
                
            } receiveValue: { post in
                print(post)
                
            }
            .store(in: &cancellable)
    }
}
