//
//  FakeData.swift
//  DefaultProject
//
//  Created by daktech on 6/10/23.
//

import Foundation

struct Province: Codable {
    let id: String
    let name: String
    let districts: [District]
}

struct District: Codable {
    let id: String
    let name: String
    let communes: [Commune]
}

struct Commune: Codable {
    let id: String
    let name: String
}


