//
//  SearchingProjectViewModel.swift
//  DefaultProject
//
//  Created by daktech on 6/19/23.
//

import Foundation
import Combine

class SearchingProjectViewModel {
    
    var cancellable : Set<AnyCancellable> = []
    
    let firestore : FirestoreProtocol
    init(firestore: FirestoreProtocol) {
        self.firestore = firestore
    }
    
    var listProvince : [AddressModel] {
        let list = Bundle.main.decode(type: [Province].self, from: "fakeJson.json")
        return list.map { province in
            AddressModel(province: province.name )
        }
    }
    
    func test(){
        
        let filter = FilterCondition(field: "imagesURLs", filterOperator: .arrayContains, value: "https://firebasestorage.googleapis.com:443/v0/b/fir-authentication-7b6d9.appspot.com/o/images%2F20230615150931CAFB25D0-302E-40B5-A326-4B49258CB65D.jpg?alt=media&token=5082f231-301f-4e4f-b529-b3f876be02e3")
        
        let test : AnyPublisher<PostModel, Error> = firestore.getDocumentsWithCondition(collection: Constants.pathDocument, conditions: [filter], orderBy: nil, decending: nil, limit: nil)
        
        test
            .sink { completion in
                
            } receiveValue: { post in
                print(post)
            }
            .store(in: &cancellable)

    }
}
