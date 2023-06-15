//
//  PostModel.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/29/23.
//

import Foundation

struct PostModel {
    
    var id : String = generateUniqueString()
    var uid: String?
    
    var category: String?
    var realEstateCategory: String?
    
    var buildingName: String?
    var address: String?
    var videoURL: String?
    var imageURLs: [String]?
    
    var apartmentCode: String?
    var block: String?
    var floor: String?
    
    var apartmentType: String?
    var bedrooms: String?
    var bathrooms: String?
    var balconyDirection: String?
    var entranceDirection: String?
    
    var legalDocuments: String?
    var interiorStatus: String?

    var area: String?
    var price: String?
    var depositAmount: String?
    
    var postTitle: String?
    var postDescription: String?
    
}


extension PostModel {
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        
        dictionary["id"] = id
        dictionary["uid"] = uid
        
        dictionary["category"] = category
        dictionary["realEstateCategory"] = realEstateCategory
        
        dictionary["buildingName"] = buildingName
        dictionary["address"] = address
        dictionary["videoURL"] = videoURL
        dictionary["imageURLs"] = imageURLs
        
        dictionary["apartmentCode"] = apartmentCode
        dictionary["block"] = block
        dictionary["floor"] = floor
        
        dictionary["apartmentType"] = apartmentType
        dictionary["bedrooms"] = bedrooms
        dictionary["bathrooms"] = bathrooms
        dictionary["balconyDirection"] = balconyDirection
        dictionary["entranceDirection"] = entranceDirection
        
        dictionary["legalDocuments"] = legalDocuments
        dictionary["interiorStatus"] = interiorStatus
        
        dictionary["area"] = area
        dictionary["price"] = price
        dictionary["depositAmount"] = depositAmount
        
        dictionary["postTitle"] = postTitle
        dictionary["postDescription"] = postDescription
        
        return dictionary
    }
}

extension PostModel : InitializableProtocol {
    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? String else {
            return nil
        }
        
        self.id = id
        self.uid = dictionary["uid"] as? String
        self.category = dictionary["category"] as? String
        self.realEstateCategory = dictionary["realEstateCategory"] as? String
        self.buildingName = dictionary["buildingName"] as? String
        self.address = dictionary["address"] as? String
        self.videoURL = dictionary["videoURL"] as? String
        self.imageURLs = dictionary["imageURLs"] as? [String]
        self.apartmentCode = dictionary["apartmentCode"] as? String
        self.block = dictionary["block"] as? String
        self.floor = dictionary["floor"] as? String
        self.apartmentType = dictionary["apartmentType"] as? String
        self.bedrooms = dictionary["bedrooms"] as? String
        self.bathrooms = dictionary["bathrooms"] as? String
        self.balconyDirection = dictionary["balconyDirection"] as? String
        self.entranceDirection = dictionary["entranceDirection"] as? String
        self.legalDocuments = dictionary["legalDocuments"] as? String
        self.interiorStatus = dictionary["interiorStatus"] as? String
        self.area = dictionary["area"] as? String
        self.price = dictionary["price"] as? String
        self.depositAmount = dictionary["depositAmount"] as? String
        self.postTitle = dictionary["postTitle"] as? String
        self.postDescription = dictionary["postDescription"] as? String
    }
}
