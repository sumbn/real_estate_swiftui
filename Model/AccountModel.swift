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

extension AccountModel {
    init?(dictionary: [String: Any]) {
        guard
            let uid = dictionary["uid"] as? String,
            let image = dictionary["image"] as? String,
            let name = dictionary["name"] as? String,
            let addressDict = dictionary["address"] as? [String: Any],
            let address = AddressModel(dictionary: addressDict),
            let phoneNumber = dictionary["phoneNumber"] as? String,
            let bio = dictionary["bio"] as? String,
            let identifyDict = dictionary["identify"] as? [String: Any],
            let identify = IDModel(dictionary: identifyDict),
            let gender = dictionary["gender"] as? String,
            let dayOfBirth = dictionary["dayOfBirth"] as? String
        else {
            return nil
        }
        
        self.uid = uid
        self.image = image
        self.name = name
        self.address = address
        self.phoneNumber = phoneNumber
        self.bio = bio
        self.identify = identify
        self.gender = gender
        self.dayOfBirth = dayOfBirth
    }
}

extension AccountModel {
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        
        dictionary["uid"] = uid
        dictionary["image"] = image
        dictionary["name"] = name
        dictionary["address"] = address.toDictionary()
        dictionary["phoneNumber"] = phoneNumber
        dictionary["bio"] = bio
        dictionary["identify"] = identify.toDictionary()
        dictionary["gender"] = gender
        dictionary["dayOfBirth"] = dayOfBirth
        
        return dictionary
    }
}


struct AddressModel {
    var province: String
    var district: String
    var commune: String
    var specific: String
}

extension AddressModel {
    init?(dictionary: [String: Any]) {
        guard
            let province = dictionary["province"] as? String,
            let district = dictionary["district"] as? String,
            let commune = dictionary["commune"] as? String,
            let specific = dictionary["specific"] as? String
        else {
            return nil
        }
        
        self.province = province
        self.district = district
        self.commune = commune
        self.specific = specific
    }
}

extension AddressModel {
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        
        dictionary["province"] = province
        dictionary["district"] = district
        dictionary["commune"] = commune
        dictionary["specific"] = specific
        
        return dictionary
    }
}


struct IDModel {
    var no : String
    var dateOfIssued: String
    var issuedBy: String
}

extension IDModel {
    init?(dictionary: [String: Any]) {
        guard
            let no = dictionary["no"] as? String,
            let dateOfIssued = dictionary["dateOfIssued"] as? String,
            let issuedBy = dictionary["issuedBy"] as? String
        else {
            return nil
        }
        
        self.no = no
        self.dateOfIssued = dateOfIssued
        self.issuedBy = issuedBy
    }
}

extension IDModel {
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        
        dictionary["no"] = no
        dictionary["dateOfIssued"] = dateOfIssued
        dictionary["issuedBy"] = issuedBy
        
        return dictionary
    }
}
