//
//  StorageProtocol.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/30/23.
//

import Foundation
import FirebaseStorage
import UIKit
import Combine

protocol StorageProtocol {
//    func uploadVideo(_ videoURL: String, completion: @escaping (Result<String, Error>) -> Void)
//    func uploadVideo(_ videoURL: String, completion: @escaping (UploadResult) -> Void)
//    func uploadImages(_ images: [UIImage], completion: @escaping (Result<[String], Error>) -> Void)
    
    func uploadImage(uiImage : UIImage) -> AnyPublisher<UploadResult, Error>
    
    
    func uploadVideo(videoURL : String) -> AnyPublisher<UploadResult, Error>
    
    func uploadImages(_ uiImages: [UIImage]) -> AnyPublisher<[UploadResult], Error>
    
//    func uploadVideo(_ videoURL: String) -> Future<UploadResult, Never>
//    func uploadVideo(_ videoURL: String) -> AnyPublisher<UploadResult, Never>
    
//    func uploadVideo(_ videoURL: String)
//    func uploadVideo(_ videoURL: String) -> AnyPublisher<UploadResult, Never>
}
