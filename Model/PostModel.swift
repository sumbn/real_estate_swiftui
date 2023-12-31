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
//    var address: String?
    
    var province_city: String?
    var district: String?
    var commune: String?
    var specificAddress: String?
    
    var videoURL: String?
    var imageURLs: [String]?
    
    var apartmentCode: String?
    var block: String?
    var floor: String?
    
    var apartmentType: String?
    var bedrooms: Int?
    var bathrooms: Int?
    var balconyDirection: String?
    var entranceDirection: String?
    
    var legalDocuments: String?
    var interiorStatus: String?

    var area: Int?
    var price: Int?
    var depositAmount: String?
    
    var postTitle: String?
    var postDescription: String?
    
    var postingTime: Double?
    
}


extension PostModel {
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        
        dictionary["id"] = id
        dictionary["uid"] = uid
        
        dictionary["category"] = category
        dictionary["realEstateCategory"] = realEstateCategory
        
        dictionary["buildingName"] = buildingName
//        dictionary["address"] = address
        dictionary["province_city"] = province_city
        dictionary["district"] = district
        dictionary["commune"] = commune
        dictionary["specificAddress"] = specificAddress
        
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
        
        dictionary["postingTime"] = postingTime
        
//        dictionary["keywordsForLookup"] = keywordsForLookup
        
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
        
        self.province_city = dictionary["province_city"] as? String
        self.district = dictionary["district"] as? String
        self.commune = dictionary["commune"] as? String
        self.specificAddress = dictionary["specificAddress"] as? String
        
        self.videoURL = dictionary["videoURL"] as? String
        self.imageURLs = dictionary["imageURLs"] as? [String]
        self.apartmentCode = dictionary["apartmentCode"] as? String
        self.block = dictionary["block"] as? String
        self.floor = dictionary["floor"] as? String
        self.apartmentType = dictionary["apartmentType"] as? String
        self.bedrooms = dictionary["bedrooms"] as? Int
        self.bathrooms = dictionary["bathrooms"] as? Int
        self.balconyDirection = dictionary["balconyDirection"] as? String
        self.entranceDirection = dictionary["entranceDirection"] as? String
        self.legalDocuments = dictionary["legalDocuments"] as? String
        self.interiorStatus = dictionary["interiorStatus"] as? String
        self.area = dictionary["area"] as? Int
        self.price = dictionary["price"] as? Int
        self.depositAmount = dictionary["depositAmount"] as? String
        self.postTitle = dictionary["postTitle"] as? String
        self.postDescription = dictionary["postDescription"] as? String
        
        self.postingTime = dictionary["postingTime"] as? Double
    }
}
