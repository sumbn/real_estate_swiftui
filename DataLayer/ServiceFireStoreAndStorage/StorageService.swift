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
    
    
    //    // Tải video lên Storage Firebase và trả về URL thông qua completion closure
    //    func uploadVideo(_ videoURL: String, completion: @escaping (Result<String, Error>) -> Void) {
    //        // Thực hiện tải lên video và nhận URL
    //        // ...
    //        // File located on disk
    //        let localFile = URL(string: videoURL)!
    //
    //        let randomName = "\(generateUniqueString()).mp4"
    //
    //        // Create a reference to the file you want to upload
    //        let reference = Storage.storage().reference().child("video/\(randomName)")
    //
    //
    //        // Create the file metadata
    //        let metadata = StorageMetadata()
    //        metadata.contentType = "video/mp4"
    //
    //        // Upload the file to the path "images/rivers.jpg"
    //        let uploadTask = reference.putFile(from: localFile, metadata: nil) { metadata, error in
    //            guard let metadata = metadata else {
    //                // Uh-oh, an error occurred!
    //                return
    //            }
    //            // Metadata contains file metadata such as size, content-type.
    //            let size = metadata.size
    //            // You can also access to download URL after upload.
    //            reference.downloadURL { (url, error) in
    //                guard let downloadURL = url else {
    //                    // Uh-oh, an error occurred!
    //                    let error = NSError(domain: "YourDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error message"])
    //                    completion(.failure(error))
    //                    return
    //                }
    //                completion(.success(downloadURL.absoluteString))
    //            }
    //        }
    //    }
    
    // Tải ảnh lên Storage Firebase và trả về mảng URL thông qua completion closure
    func uploadImages(_ images: [UIImage], completion: @escaping (Result<[String], Error>) -> Void) {
        var uploadedImageURLs: [String] = []
        let dispatchGroup = DispatchGroup()
        
        for image in images {
            
            dispatchGroup.enter()
            
            uploadImage(uiImage: image) { url in
                uploadedImageURLs.append(url)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(.success(uploadedImageURLs))
            print("urls image is: \(uploadedImageURLs)")
        }
    }
    
    
    func uploadImage(uiImage : UIImage, getUrl: @escaping (String) -> Void) {
        
        guard let dataImage = uiImage.jpegData(compressionQuality: 0.5) else {
            print("cannot convert to data from uiimage")
            return
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
                
                getUrl(downloadURL.absoluteString)
            }
        }
    }
    
    
    // Tải video lên Storage Firebase và trả về URL thông qua completion closure
    func uploadVideo(_ videoURL: String, completion: @escaping (UploadResult) -> Void) {
        // Thực hiện tải lên video và nhận URL
        // ...
        // File located on disk
        let localFile = URL(string: videoURL)!
        
        let randomName = "\(generateUniqueString()).mp4"
        
        // Create a reference to the file you want to upload
        let reference = Storage.storage().reference().child("video/\(randomName)")
        
        
        // Create the file metadata
        let metadata = StorageMetadata()
        metadata.contentType = "video/mp4"
        
        // Upload file and metadata to the object 'images/mountains.jpg'
        let uploadTask = reference.putFile(from: localFile, metadata: metadata)
        
        // Listen for state changes, errors, and completion of the upload.
        uploadTask.observe(.resume) { snapshot in
            // Upload resumed, also fires when the upload starts
           
        }
        
        uploadTask.observe(.pause) { snapshot in
            // Upload paused
        }
        
        uploadTask.observe(.progress) { snapshot in
            // Upload reported progress
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
            / Double(snapshot.progress!.totalUnitCount)
            
            completion(.progress(percentComplete))
        }
        
        uploadTask.observe(.success) { snapshot in
            // Upload completed successfully
            reference.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    let error = NSError(domain: "YourDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error message"])
                    completion(.failure(error))
                    return
                }
                completion(.success(downloadURL.absoluteString))
            }
        }
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as? NSError {
                completion(.failure(error))
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    // File doesn't exist
                    break
                case .unauthorized:
                    // User doesn't have permission to access file
                    break
                case .cancelled:
                    // User canceled the upload
                    break
                    
                    /* ... */
                    
                case .unknown:
                    // Unknown error occurred, inspect the server response
                    break
                default:
                    // A separate error occurred. This is a good place to retry the upload.
                    break
                }
            }
        }
        
        //        // Upload the file to the path "images/rivers.jpg"
        //        let uploadTask = reference.putFile(from: localFile, metadata: nil) { metadata, error in
        //            guard let metadata = metadata else {
        //                // Uh-oh, an error occurred!
        //                return
        //            }
        //            // Metadata contains file metadata such as size, content-type.
        //            let size = metadata.size
        //            // You can also access to download URL after upload.
        //            reference.downloadURL { (url, error) in
        //                guard let downloadURL = url else {
        //                    // Uh-oh, an error occurred!
        //                    let error = NSError(domain: "YourDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error message"])
        //                    completion(.failure(error))
        //                    return
        //                }
        //                completion(.success(downloadURL.absoluteString))
        //            }
        //        }
    }
}

enum UploadResult {
    case progress(Double)
    case success(String)
    case failure(Error)
}
