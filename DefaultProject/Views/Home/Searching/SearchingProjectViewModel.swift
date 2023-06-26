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
    
    @Published var listAccount = [String]()
    
    func filterData(filter: [FilterCondition], orderBy: String?, decending: Bool?, limit: Int?){
        
        withAnimation(.easeInOut) {
            listSearchedItem.removeAll()
        }
        
        let test : AnyPublisher<PostModel, Error> = firestore.getDocumentsWithCondition(collection: Constants.pathDocument, conditions: filter, orderBy: orderBy, decending: decending, limit: limit)
        
        //        test
        //            .sink { completion in
        //
        //            } receiveValue: { post in
        //                print(post)
        //                withAnimation(.easeInOut) {
        //                    self.listSearchedItem.append(post)
        //                }
        //            }
        //            .store(in: &cancellable)
        
        
        test
            .flatMap { post -> AnyPublisher<ResultGetDocument<AccountModel>, Error> in
                withAnimation(.easeInOut) {
                    self.listSearchedItem.append(post)
                }
                return self.firestore.getDocument(path: Constants.pathAccount, post.uid!)
            }
            .sink { completion in
                
            } receiveValue: { result in
                switch result {
                case .failure(let err):
                    print(err)
                case .success(let account):
                    print(account.name ?? "error")
                    self.listAccount.append(account.name ?? "")
//                    self.nameUser = account.name ?? ""
                }
            }
            .store(in: &cancellable)
        
    }
    
}

