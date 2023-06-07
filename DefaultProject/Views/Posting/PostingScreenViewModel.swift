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

        //    Tải video lên Storage Firebase
        if(linkVideoURL != nil){
            storageService.uploadVideo(videoURL: linkVideoURL!)
                .sink { result in
                    switch result {
                    case .finished: break
                    case .failure(_) : break
                    }
                } receiveValue: { result in
                    switch result {
                    case .success(let url):
                        videoURL = url
                        print("success: \(url)")

                    case .progress(let double):
                        self.progressUploadVideo = double/100
                        print("progress: \(double)")

                    case .failure(_) : break
                    }

                }
                .store(in: &cancellables)
        }

        observeUploadProgress(for: images)

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
    
    func observeUploadProgress(for images: [UIImage]) {
        let publishers = images.enumerated().map { index, image in
            storageService.uploadImage(uiImage: image)
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
                DispatchQueue.main.async {
                    self?.updateResult(result, at: index)
                }
            })
            .store(in: &cancellables)
    }
    
    private func updateResult(_ result: UploadResult, at index: Int) {
        if index < imageResults.count {
            imageResults[index] = result
        } else {
            imageResults.append(result)
        }
    }
    
    //    func observeUploadProgress(for images: [UIImage]) {
    //        storageService.uploadImages(images)
    //                .sink(receiveCompletion: { completion in
    //                    // Xử lý khi quá trình theo dõi hoàn thành (hoặc có lỗi)
    //                    switch completion {
    //                    case .finished:
    //                        print("Hoàn thành theo dõi tiến trình upload")
    //                    case .failure(let error):
    //                        print("Lỗi khi theo dõi tiến trình upload: \(error)")
    //                    }
    //                }, receiveValue: { results in
    //                    // Xử lý giá trị tiến trình và kết quả từng ảnh
    //                    for (index, result) in results.enumerated() {
    //                        switch result {
    //                        case .success(let downloadURL):
    //                            print("Download URL của ảnh \(index): \(downloadURL)")
    //                        case .progress(let progress):
    //                            self.progressUploadImages.append(progress)
    //                            print("Tiến trình upload của ảnh \(index): \(progress)%")
    //                        case .failure(let error):
    //                            print("Lỗi khi upload ảnh \(index): \(error)")
    //                        }
    //                    }
    //                })
    //                .store(in: &cancellables)
    //    }
    
    
    
    
    
    
    
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
    
    func testPush(url : String?){
        
        if(url != nil){
            storageService.uploadVideo(videoURL: url!)
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

