//
//  StorageProtocol.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/30/23.
//

import Foundation
import FirebaseStorage
import UIKit

protocol StorageProtocol {
    func uploadVideo(_ videoURL: String, completion: @escaping (Result<String, Error>) -> Void)
    func uploadImages(_ images: [UIImage], completion: @escaping (Result<[String], Error>) -> Void)
}
