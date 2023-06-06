//
//  PostingScreenViewModel.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/26/23.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import Combine


class PostingScreenViewModel : ObservableObject {
    
    @Published var progressUploadVideo: Double = 0.0
    
    
    
    private var cancellables = Set<AnyCancellable>()
    private var progressSubject = CurrentValueSubject<Double, Never>(0.0)
    
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
            storageService.uploadVideo(videoURL: linkVideoURL!)
                .receive(on: DispatchQueue.main)
                .sink { _ in
                    
                } receiveValue: { result in
                    switch result {
                    case .success(let string):
                        print("success: \(string)")
                        
                    case .progress(let double):
                        self.progressUploadVideo = double/100
                        print("progress: \(double)")
                        
                    case .failure(_) : break
                    }
                    
                }
                .store(in: &cancellables)
        }
        
        // Tải ảnh lên Storage Firebase
        dispatchGroup.enter()
        
        storageService.uploadImages(images) { result in
            switch result {
            case .success(let urls):
                imageUrls = urls
            case .failure(_): break
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
    
    func testPush(url : String?){
        
        //         Tải video lên Storage Firebase
        if(url != nil){
            
            storageService.uploadVideo(videoURL: url!)
                .receive(on: DispatchQueue.main)
                .sink { _ in
                    
                } receiveValue: { result in
                    switch result {
                    case .success(let string):
                        print("success: \(string)")
                        
                    case .progress(let double):
                        self.progressUploadVideo = double/100
                        print("progress: \(double)")
                        
                    case .failure(_) : break
                        
                    }
                }
                .store(in: &cancellables)
        }
    }
}

