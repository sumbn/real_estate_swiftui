//
//  AddressModel.swift
//  DefaultProject
//
//  Created by daktech on 6/12/23.
//

import Foundation

struct AccountModel {
    var uid: String?
    var subcriber: [String]?
    var image: String?
    var name : String?
//    var address: AddressModel?
    var province: String?
    var district: String?
    var commune: String?
    var specific: String?
    
    var noId: String?
    var dateOfIssued: String?
    var issuedBy: String?
    
    
    var phoneNumber: String?
    var bio: String?
//    var identify: IDModel?
    var gender: String?
    var dayOfBirth: String?
}

extension AccountModel : InitializableProtocol{

    init?(dictionary: [String: Any]) {
        
        self.uid = dictionary["uid"] as? String
        self.subcriber = dictionary["subcriber"] as? [String]
        self.image = dictionary["image"] as? String
        self.name = dictionary["name"] as? String
//        self.address = AddressModel(dictionary: ((dictionary["address"] as? [String: Any])!))
        self.province = dictionary["province"] as? String
        self.district = dictionary["district"] as? String
        self.commune = dictionary["commune"] as? String
        self.specific = dictionary["specific"] as? String
        
        self.noId = dictionary["noId"] as? String
        self.dateOfIssued = dictionary["dateOfIssued"] as? String
        self.issuedBy = dictionary["issuedBy"] as? String
        
        
        self.phoneNumber = dictionary["phoneNumber"] as? String
        self.bio = dictionary["bio"] as? String
//        self.identify = IDModel(dictionary: ((dictionary["identify"] as? [String: Any])!))
        self.gender = dictionary["gender"] as? String
        self.dayOfBirth = dictionary["dayOfBirth"] as? String
    }
}

extension AccountModel {
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        
        dictionary["uid"] = uid
        dictionary["subcriber"] = subcriber
        dictionary["image"] = image
        dictionary["name"] = name
//        dictionary["address"] = address!.toDictionary()
        dictionary["province"] = province
        dictionary["district"] = district
        dictionary["commune"] = commune
        dictionary["specific"] = specific
        
        dictionary["phoneNumber"] = phoneNumber
        dictionary["bio"] = bio
        
//        dictionary["identify"] = identify!.toDictionary()
        dictionary["noId"] = noId
        dictionary["dateOfIssued"] = dateOfIssued
        dictionary["issuedBy"] = issuedBy
        
        
        dictionary["gender"] = gender
        dictionary["dayOfBirth"] = dayOfBirth
        
        return dictionary
    }
}


//struct AddressModel : Codable, Hashable {
//    var province: String?
//    var district: String?
//    var commune: String?
//    var specific: String?
//}
//
//
//extension AddressModel {
//    init?(dictionary: [String: Any]) {
//        self.province = dictionary["province"] as? String
//        self.district = dictionary["district"] as? String
//        self.commune = dictionary["commune"] as? String
//        self.specific = dictionary["specific"] as? String
//    }
//}
//
//extension AddressModel {
//    func toDictionary() -> [String: Any] {
//        var dictionary: [String: Any] = [:]
//        
//        dictionary["province"] = province
//        dictionary["district"] = district
//        dictionary["commune"] = commune
//        dictionary["specific"] = specific
//        
//        return dictionary
//    }
//}
//
//struct IDModel {
//    var no : String?
//    var dateOfIssued: String?
//    var issuedBy: String?
//}
//
//extension IDModel {
//    init?(dictionary: [String: Any]) {
//        self.no = dictionary["no"] as? String
//        self.dateOfIssued = dictionary["dateOfIssued"] as? String
//        self.issuedBy = dictionary["issuedBy"] as? String
//    }
//}
//
//extension IDModel {
//    func toDictionary() -> [String: Any] {
//        var dictionary: [String: Any] = [:]
//        
//        dictionary["no"] = no
//        dictionary["dateOfIssued"] = dateOfIssued
//        dictionary["issuedBy"] = issuedBy
//        
//        return dictionary
//    }
//}
