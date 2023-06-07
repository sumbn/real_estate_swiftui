//
//  StorageService.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/30/23.
//

import Foundation
import FirebaseStorage
import UIKit
import Combine


class StorageService : StorageProtocol {
    
    
    func uploadVideo(videoURL : String) -> AnyPublisher<UploadResult, Error> {
        
        let subject = PassthroughSubject<UploadResult, Error>()
        
        // File located on disk
        let localFile = URL(string: videoURL)!
        
        let randomName = "\(generateUniqueString()).mp4"
        
        // Create a reference to the file you want to upload
        let reference = Storage.storage().reference().child("video/\(randomName)")
        
        
        // Create the file metadata
        let metadata = StorageMetadata()
        metadata.contentType = "video/mp4"
        
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = reference.putFile(from: localFile, metadata: nil) { metadata, error in
            guard let metadata = metadata else { return }
            
            let size = metadata.size
            
            reference.downloadURL { (url, error) in
                guard let downloadURL = url else {
                   
                    let error = NSError(domain: "YourDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error message"])

                    subject.send(.failure(error))
                    return
                }
                
                subject.send(.success(downloadURL.absoluteString))
            }
        }
        
        uploadTask.observe(.progress) { snapshot in
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
            / Double(snapshot.progress!.totalUnitCount)
            
            subject.send(.progress(percentComplete))
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    
    
//    // Tải ảnh lên Storage Firebase và trả về mảng URL thông qua completion closure
//    func uploadImages(_ images: [UIImage], completion: @escaping (Result<[String], Error>) -> Void) {
//        var uploadedImageURLs: [String] = []
//        let dispatchGroup = DispatchGroup()
//        
//        for image in images {
//            
//            dispatchGroup.enter()
//            
//            uploadImage(uiImage: <#T##UIImage#>)
//        }
//        
//        dispatchGroup.notify(queue: .main) {
//            completion(.success(uploadedImageURLs))
//            print("urls image is: \(uploadedImageURLs)")
//        }
//    }
    
    
//    func uploadImage(uiImage : UIImage, getUrl: @escaping (String) -> Void) {
//
//        guard let dataImage = uiImage.jpegData(compressionQuality: 0.5) else {
//            print("cannot convert to data from uiimage")
//            return
//        }
//
//
//        let metadata = StorageMetadata()
//        metadata.contentType = "image/jpeg"
//
//        let randomName = "\(generateUniqueString()).jpg"
//
//
//        let reference = Storage.storage().reference().child("upload/\(randomName)")
//
//
//
//        let uploadTask = reference.putData(dataImage, metadata: metadata) { (metadata, error) in
//            guard let metadata = metadata else {
//
//                return
//            }
//
//
//            let size = metadata.size
//
//            reference.downloadURL { (url, error) in
//                guard let downloadURL = url else {
//
//                    return
//                }
//
//                getUrl(downloadURL.absoluteString)
//            }
//        }
//    }
    
//
//    func uploadImages(_ uiImages: [UIImage]) -> AnyPublisher<UploadResult, Error> {
//        let publishers = uiImages.map { uiImage in
//                uploadImage(uiImage: uiImage)
//                    .map { result -> UploadResult in
//                        switch result {
//                        case .success(let downloadURL):
//                            return .success(downloadURL)
//                        case .progress(let progress):
//                            return .progress(progress)
//                        case .failure(let error):
//                            return .failure(error)
//                        }
//                    }
//                    .eraseToAnyPublisher()
//            }
//
//            return Publishers.MergeMany(publishers)
//                .eraseToAnyPublisher()
//    }
    
    func uploadImages(_ uiImages: [UIImage]) -> AnyPublisher<[UploadResult], Error> {
        let publishers = uiImages.enumerated().map { (index, uiImage) -> AnyPublisher<UploadResult, Error> in
            return uploadImage(uiImage: uiImage)
                .mapError { error -> Error in
                    return error
                }
                .map { result -> UploadResult in
                    switch result {
                    case .progress(let progress):
                        return .progress(progress)
                    case .success(let downloadURL):
                        return .success(downloadURL)
                    case .failure(let error):
                        return .failure(error)
                    }
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
        
        return Publishers.MergeMany(publishers)
            .collect()
            .eraseToAnyPublisher()
    }
    
    func uploadImage(uiImage : UIImage) -> AnyPublisher<UploadResult, Error> {
        
        let subject = PassthroughSubject<UploadResult, Error>()
        
        guard let dataImage = uiImage.jpegData(compressionQuality: 0.5) else {
            print("cannot convert to data from uiimage")
            let error = NSError(domain: "YourDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error converting UIImage to Data"])
            subject.send(.failure(error))
            return subject.eraseToAnyPublisher()
        }
        
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let randomName = "\(generateUniqueString()).jpg"
        
        let reference = Storage.storage().reference().child("upload/\(randomName)")
        
        let uploadTask = reference.putData(dataImage, metadata: metadata) { (metadata, error) in
            guard let metadata = metadata else {
                return
            }
            
            
            let size = metadata.size
            
            reference.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    
                    return
                }
                
                subject.send(.success(downloadURL.absoluteString))
            }
        }
        
        uploadTask.observe(.progress) { snapshot in
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
            / Double(snapshot.progress!.totalUnitCount)
            
            subject.send(.progress(percentComplete))
        }
        
        return subject.eraseToAnyPublisher()
    }
    
}



enum UploadResult {
    case progress(Double)
    case success(String)
    case failure(Error)
}
