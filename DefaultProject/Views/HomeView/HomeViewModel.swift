//
//  HomeViewmodel.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/15/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var isLoggedIn = false

    private var cancellables: Set<AnyCancellable> = []

    init() {
       
    }
}
