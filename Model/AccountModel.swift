//
//  AddressModel.swift
//  DefaultProject
//
//  Created by daktech on 6/12/23.
//

import Foundation

struct AccountModel {
    var uid: String
    var image: String
    var name : String
    var address: AddressModel
    var phoneNumber: String
    var bio: String
    var identify: IDModel
    var gender: String
    var dayOfBirth: String
}


struct AddressModel {
    var province: String
    var district: String
    var commune: String
    var specific: String
}

struct IDModel {
    var no : String
    var dateOfIssued: String
    var issuedBy: String
}
