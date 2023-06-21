//
//  PostModelBuilder.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/30/23.
//

import Foundation
class PostModelBuilder {
    private var post: PostModel
    
    init() {
        post = PostModel()
    }
    
    init(post: PostModel) {
        self.post = post
    }
    
    func setId(_ id: String) -> Self {
        post.id = id
        return self
    }
    
    func setCategory(_ category: String) -> Self {
        post.category = category
        return self
    }
    
    func setRealEstateCategory(_ realEstateCategory: String) -> Self {
        post.realEstateCategory = realEstateCategory
        return self
    }
    
    func setUId(_ uid: String) -> Self {
        post.uid = uid
        return self
    }
    
    func setBuildingName(_ buildingName: String) -> Self {
        post.buildingName = buildingName
        return self
    }
    
    func setProvince(_ province: String) -> Self {
        post.province_city = province
        return self
    }
    
    func setDistrict(_ district: String) -> Self {
        post.district = district
        return self
    }
    
    func setCommune(_ commune: String) -> Self {
        post.commune = commune
        return self
    }
    
    func setSpecificAddress(_ specificAddress: String?) -> Self {
        post.specificAddress = specificAddress
        return self
    }
    
    func setVideoURL(_ videoURL: String?) -> Self {
        post.videoURL = videoURL
        return self
    }
    
    func setImageURLs(_ imageURLs: [String]?) -> Self {
        post.imageURLs = imageURLs
        return self
    }
    
    
    func setApartmentCode(_ apartmentCode: String?) -> Self {
        post.apartmentCode = apartmentCode
        return self
    }
    
    func setBlock(_ block: String?) -> Self {
        post.block = block
        return self
    }
    
    func setFloor(_ floor: String?) -> Self {
        post.floor = floor
        return self
    }
    
    
    func setApartmentType(_ apartmentType: String?) -> Self {
        post.apartmentType = apartmentType
        return self
    }
    
    func setBedrooms(_ bedrooms: Int?) -> Self {
        post.bedrooms = bedrooms
        return self
    }
    
    func setBathrooms(_ bathrooms: Int?) -> Self {
        post.bathrooms = bathrooms
        return self
    }
    
    func setBalconyDirection(_ balconyDirection: String?) -> Self {
        post.balconyDirection = balconyDirection
        return self
    }
    
    func setEntranceDirection(_ entranceDirection: String?) -> Self {
        post.entranceDirection = entranceDirection
        return self
    }
    
    
    func setLegalDocuments(_ legalDocuments: String?) -> Self {
        post.legalDocuments = legalDocuments
        return self
    }
    
    func setInteriorStatus(_ interiorStatus: String?) -> Self {
        post.interiorStatus = interiorStatus
        return self
    }
    
    
    func setArea(_ area: Int?) -> Self {
        post.area = area
        return self
    }
    
    func setPrice(_ price: Int?) -> Self {
        post.price = price
        return self
    }
    
    func setDepositAmount(_ depositAmount: String?) -> Self {
        post.depositAmount = depositAmount
        return self
    }
    
    
    func setPostTitle(_ postTitle: String?) -> Self {
        post.postTitle = postTitle
        return self
    }
    
    func setPostDecription(_ postDecription: String?) -> Self {
        post.postDescription = postDecription
        return self
    }
    
    func build() -> PostModel {
        return post
    }
}
