//
//  SearchingProjectViewModel.swift
//  DefaultProject
//
//  Created by daktech on 6/19/23.
//

import Foundation
import Combine
import SwiftUI

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
//                print(post.uid)
                withAnimation {
                    self.listSearchedItem.append(post)
                }
            }
            .store(in: &cancellable)
        
    }
}
