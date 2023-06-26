//
//  AllProjectViewModel.swift
//  DefaultProject
//
//  Created by daktech on 6/24/23.
//

import Foundation
import Combine
import SwiftUI
import FirebaseFirestore

class AllProjectViewModel : ObservableObject {
    private let firestore: FirestoreProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published var listPurchasePost : [PostModel] = []
    
    @Published var listLeasingPost : [PostModel] = []
    
    @Published var search: String = ""
    {
        willSet(newValue){
            if newValue == "" {
                listSearchedPost = []
            }
        }
    }
    
    var listSearchedPost : [PostModel] = []
    {
        didSet {
            sortedListSearched = listSearchedPost.sorted(by: { $0.postingTime ?? 0 > $1.postingTime ?? 0 })
        }
    }
    
    @Published var sortedListSearched : [PostModel] = []
    
    var test : [PostModel] {
        return listSearchedPost.sorted(by: { $0.postingTime ?? 0 > $1.postingTime ?? 0 })
    }
    
    init(firestore: FirestoreProtocol) {
        self.firestore = firestore
    }
    
    func getPurchasingProjects(){
        
        let filter = FilterCondition(field: "realEstateCategory", filterOperator: .isEqualTo, value: "Cần bán")
        
        let getProjects : AnyPublisher<PostModel, Error> = firestore.getDocumentsWithCondition(collection: Constants.pathDocument, conditions: [filter], orderBy: "postingTime", decending: true, limit: nil)
        
        getProjects
            .sink { completion in
                
            } receiveValue: { post in
                
                withAnimation {
                    self.listPurchasePost.append(post)
                }
            }
            .store(in: &cancellables)
    }
    
    func getLeasingProjects(){
        
        let filter = FilterCondition(field: "realEstateCategory", filterOperator: .isEqualTo, value: "Cho thuê")
        
        let getProjects : AnyPublisher<PostModel, Error> = firestore.getDocumentsWithCondition(collection: Constants.pathDocument, conditions: [filter], orderBy: "postingTime", decending: true, limit: nil)
        
        getProjects
            .sink { completion in
                
            } receiveValue: { post in
                withAnimation {
                    self.listLeasingPost.append(post)
                }
            }
            .store(in: &cancellables)
    }
    
    func searchProject(){
        
        withAnimation {
            listSearchedPost = []
        }
        
        var filters : [FilterCondition] = []
        
        filters.append(FilterCondition(field: "postTitle", filterOperator: .isGreaterThanOrEqualTo, value: search.lowercased()))
        filters.append(FilterCondition(field: "postTitle", filterOperator: .isLessThan, value: search.lowercased() + "\u{f8ff}"))
        
        let getProjects : AnyPublisher<PostModel, Error> = firestore.getDocumentsWithCondition(collection: Constants.pathDocument, conditions: filters, orderBy: nil, decending: nil, limit: nil)
        
        getProjects
            .sink { completion in
                
            } receiveValue: { post in
                print(Date(timeIntervalSince1970: post.postingTime!).dateFormatWithTimezone7)
                withAnimation {
                    self.listSearchedPost.append(post)
                }
            }
            .store(in: &cancellables)
        
    }
    
}
