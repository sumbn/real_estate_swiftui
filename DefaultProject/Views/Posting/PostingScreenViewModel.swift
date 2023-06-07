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
    
    @Published var progressUploadImages: [Double] = []
    
    @Published var imageResults: [UploadResult] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    private var progressSubject = CurrentValueSubject<Double, Never>(0.0)
    
    private let firestoreService: FirestoreProtocol
    private let storageService: StorageProtocol
    
    init(firestoreService: FirestoreProtocol, storageService: StorageProtocol) {
        self.firestoreService = firestoreService
        self.storageService = storageService
        
    }
    
    func createPost(withVideo linkVideoURL: String?, andImages images: [UIImage], post: PostModel, completion: @escaping (Result<String, Error>) -> Void) {
        var videoURL: String?
        var imageUrls: [String] = []
        
        let dispatchGroup = DispatchGroup()
        if(linkVideoURL != nil){
            dispatchGroup.enter()
            storageService.uploadVideo(videoURL: linkVideoURL!)
                .handleEvents(receiveCompletion: { _ in
                    dispatchGroup.leave()
                })
                .sink { result in
                    switch result {
                    case .finished: break
                    case .failure(_) : break
                    }
                } receiveValue: { result in
                    switch result {
                    case .success(let url):
                        videoURL = url
                        dispatchGroup.leave()
                        
                    case .progress(let double):
                        self.progressUploadVideo = double/100
                        print("progress: \(double)")
                        
                    case .failure(_) :
                        dispatchGroup.leave()
                    }
                }
                .store(in: &cancellables)
        }
    }
    
    private func handleUploadCompletion(videoUrl: String?, imageUrls: [String], post: PostModel, completion: @escaping (Result<String, Error>) -> Void) {
        let updatePost = PostModelBuilder(post: post)
            .setVideoURL(videoUrl ?? "Test")
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
    
    func uploadImages(for images: [UIImage]) {
    
        let dispatcherGroup = DispatchGroup()
        
       
        let publishers = images.enumerated().map { index, image in
            
            dispatcherGroup.enter()
            
            return storageService.uploadImage(uiImage: image)
                .map { result -> (Int, UploadResult) in
                    switch result {
                    case .success(let downloadURL):
                        return (index, .success(downloadURL))
                    case .progress(let progress):
                        return (index, .progress(progress))
                    case .failure(let error):
                        return (index, .failure(error))
                    }
                }
                .catch { error -> AnyPublisher<(Int, UploadResult), Never> in
                    return Just((index, .failure(error)))
                        .eraseToAnyPublisher()
                }
        }
        
        Publishers.MergeMany(publishers)
            .sink(receiveValue: { [weak self] (index, result) in

                switch result {

                case .progress(_):
                    self?.updateResult(result, at: index)
                    print("đã update images")
                case .success(_):
                    dispatcherGroup.leave()
                case .failure(_): break
                }
            })
            .store(in: &cancellables)
        
        dispatcherGroup.notify(queue: .main){
            print("success")
        }
   
    }
    
    func testComplete(linkVideoURL: String?){
        
    }
    
    
    private func updateResult(_ result: UploadResult, at index: Int) {
        if index < imageResults.count {
            imageResults[index] = result
        } else {
            imageResults.append(result)
        }
    }
    
    
    //    func createPost(withVideo linkVideoURL: String?, andImages images: [UIImage], post: PostModel, completion: @escaping (Result<String, Error>) -> Void) {
    //        let dispatchGroup = DispatchGroup()
    //        var videoURL: String?
    //        var imageUrls: [String] = []
    //
    //        //    Tải video lên Storage Firebase
    //        if(linkVideoURL != nil){
    //            storageService.uploadVideo(videoURL: linkVideoURL!)
    //                .sink { result in
    //                    switch result {
    //                    case .finished: break
    //                    case .failure(_) : break
    //                    }
    //                } receiveValue: { result in
    //                    switch result {
    //                    case .success(let url):
    //                        videoURL = url
    //                        print("success: \(url)")
    //
    //                    case .progress(let double):
    //                        self.progressUploadVideo = double/100
    //                        print("progress: \(double)")
    //
    //                    case .failure(_) : break
    //                    }
    //
    //                }
    //                .store(in: &cancellables)
    //        }
    //
    //        // Tải ảnh lên Storage Firebase
    //        dispatchGroup.enter()
    //
    //        storageService.uploadImages(images) { result in
    //            switch result {
    //            case .success(let urls):
    //                imageUrls = urls
    //            case .failure(_): break
    //                // Xử lý lỗi tải lên ảnh
    //                // ...
    //            }
    //            dispatchGroup.leave()
    //        }
    //
    //
    //        dispatchGroup.notify(queue: DispatchQueue.main) {
    //                let updatePost = PostModelBuilder(post: post)
    //                    .setVideoURL(videoURL ?? "Test")
    //                    .setImageURLs(imageUrls)
    //                    .build()
    //
    //                // Save the post object to Firestore
    //                self.firestoreService.addDocument(updatePost) { result in
    //                    switch result {
    //                    case .success(let string):
    //                        completion(.success(string))
    //                        // Post saved successfully
    //                        // ...
    //                    case .failure(let error):
    //                        completion(.failure(error))
    //                        // Handle error while saving post
    //                        // ...
    //                    }
    //                }
    //        }
    //
    //    }
}

