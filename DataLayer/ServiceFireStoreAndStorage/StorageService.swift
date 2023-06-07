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
