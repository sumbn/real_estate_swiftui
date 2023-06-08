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
    
//    @Published var imageResults: [UploadResult] = []
    
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
                        self.progressUploadVideo = double / 100
                        print("progress video: \(double)")
                        
                    case .failure(_) :
                        dispatchGroup.leave()
                    }
                }
                .store(in: &cancellables)
        }
        
        let publishers = images.enumerated().map { index, image in
            
            dispatchGroup.enter()
            
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
                    
                case .progress(let double):
//                    print("progress image: \(result) + \(index)")
                    print("viewmodel + image: \(double)")
                    self?.progressUploadImages[index] = double / 100
//                    self?.updateResult(result, at: index)
                    
                case .success(let urlImage):
                    imageUrls.append(urlImage)
                    dispatchGroup.leave()
                case .failure(_): break
                }
            })
            .store(in: &cancellables)
        
        
        dispatchGroup.notify(queue: .main){
            self.handleUploadCompletion(videoUrl: videoURL, imageUrls: imageUrls, post: post, completionHandler: completion)
        }
    }
    
    private func handleUploadCompletion(videoUrl: String?, imageUrls: [String], post: PostModel, completionHandler: @escaping (Result<String, Error>) -> Void) {
        let updatePost = PostModelBuilder(post: post)
            .setVideoURL(videoUrl ?? "Test")
            .setImageURLs(imageUrls)
            .build()
        
        firestoreService.addDocument(updatePost)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    completionHandler(.success("thành công"))
//                    print("Hoàn thành")
                case .failure(let error):
                    completionHandler(.failure(error))
                    print("Lỗi: \(error)")
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
    }
    
//    private func updateResult(_ result: UploadResult, at index: Int) {
////        if index < imageResults.count {
////            imageResults[index] = result
////        } else {
////            imageResults.append(result)
////        }
//
//        switch result{
//        case .progress(let double):
//            print("viewmodel + image2: \(double)")
//            progressUploadImages[index] = double
//        case .success(_): break
//
//        case .failure(_): break
//
//        }
//    }
}
