//
//  HomeViewmodel.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/15/23.
//

import Foundation
import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    
    private let firestore : FirestoreProtocol
    @Published var listPurchasingRealEstate : [PostModel] = []
    @Published var listLeaseRealEstate : [PostModel] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(firestore: FirestoreProtocol) {
        self.firestore = firestore
    }
    
    func getAllPurchasingPost(){
        
        let fiter = FilterCondition(field: "realEstateCategory", filterOperator: .isEqualTo, value: "Cần bán")
        let getDoc : AnyPublisher<PostModel, Error> = firestore.getDocumentsWithCondition(collection: Constants.pathDocument, conditions: [fiter], orderBy: nil, decending: nil, limit: 4)
        
        getDoc
            .sink { completion in
                
            } receiveValue: { element in
                withAnimation {
                    self.listPurchasingRealEstate.append(element)
                }
            }
            .store(in: &cancellables)
    }
    
    func getAllLeasePost(){
        let fiter = FilterCondition(field: "realEstateCategory", filterOperator: .isEqualTo, value: "Cho thuê")
        let getDoc : AnyPublisher<PostModel, Error> = firestore.getDocumentsWithCondition(collection: Constants.pathDocument, conditions: [fiter], orderBy: nil, decending: nil, limit: 4)
        
        getDoc
            .sink { completion in
                
            } receiveValue: { element in
                withAnimation {
                    self.listLeaseRealEstate.append(element)
                }
            }
            .store(in: &cancellables)
    }
}
