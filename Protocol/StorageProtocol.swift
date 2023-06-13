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
    
    func uploadImage(uiImage: UIImage) -> AnyPublisher<UploadResult, Error>
    
    func uploadVideo(videoURL: String) -> AnyPublisher<UploadResult, Error>
}
