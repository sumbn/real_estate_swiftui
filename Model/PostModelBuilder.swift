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
    
    func setUId(_ uid: String) -> Self {
        post.uid = uid
        return self
    }
    
    func setBuildingName(_ buildingName: String?) -> Self {
        post.buildingName = buildingName
        return self
    }
    
    func setAddress(_ address: String?) -> Self {
        post.address = address
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
    
    func setBedrooms(_ bedrooms: String?) -> Self {
        post.bedrooms = bedrooms
        return self
    }
    
    func setBathrooms(_ bathrooms: String?) -> Self {
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
    
    
    func setArea(_ area: String?) -> Self {
        post.area = area
        return self
    }
    
    func setPrice(_ price: String?) -> Self {
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
