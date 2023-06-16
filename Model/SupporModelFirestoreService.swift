//
//  SupporModelFirestoreService.swift
//  DefaultProject
//
//  Created by daktech on 6/16/23.
//

import Foundation

struct FilterCondition {
    let field: String
    let filterOperator: FilterOperator
    let value: Any
}

enum FilterOperator {
    case isEqualTo
    case isGreaterThan
    case isLessThan
}

enum ResultGetDocument <T> {
    case success(T)
    case failure(Error)
}
