//
//  PostingScreenViewModel.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/26/23.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage


class PostingScreenViewModel {
    
    private let firestoreService: FirestoreProtocol
    private let storageService: StorageProtocol
    
    init(firestoreService: FirestoreProtocol, storageService: StorageProtocol) {
        self.firestoreService = firestoreService
        self.storageService = storageService
    }
    
    func createPost(withVideo linkVideoURL: String?, andImages images: [UIImage], post: PostModel, completion: @escaping (Result<String, Error>) -> Void) {
        let dispatchGroup = DispatchGroup()
        var videoURL: String?
        var imageUrls: [String] = []
        
//         Tải video lên Storage Firebase
        if(linkVideoURL != nil){
            dispatchGroup.enter()
            storageService.uploadVideo(linkVideoURL!) { result in
                switch result {
                case .success(let url):
                    videoURL = url
                case .failure(let error): break
                    // Xử lý lỗi tải lên video
                    // ...
                }
                dispatchGroup.leave()
            }
        }
        
        // Tải ảnh lên Storage Firebase
        dispatchGroup.enter()
        
        storageService.uploadImages(images) { result in
            switch result {
            case .success(let urls):
                imageUrls = urls
            case .failure(let error): break
                // Xử lý lỗi tải lên ảnh
                // ...
            }
            dispatchGroup.leave()
        }
        
        
        
        dispatchGroup.notify(queue: DispatchQueue.main) {            
            let updatePost = PostModelBuilder(post: post)
                .setVideoURL(videoURL ?? "Test")
                .setImageURLs(imageUrls)
                .build()
            
            // Save the post object to Firestore
            self.firestoreService.addDocument(updatePost) { result in
                switch result {
                case .success(let string):
                    completion(.success(string))
                    // Post saved successfully
                    // ...
                case .failure(let error):
                    completion(.failure(error))
                    // Handle error while saving post
                    // ...
                }
            }
        }
        
    }
}
