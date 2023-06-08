//
//  ImagePicker.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/30/23.
//

import Foundation
import SwiftUI
import PhotosUI

struct ImagePicker : UIViewControllerRepresentable {
    
    var typePicker: TypePicker
    var getUrlVideo: ((URL?)-> Void)?
    var getUIImage:((UIImage) -> Void)?
    //    private let controller = UIImagePickerController()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = typePicker == .image ? .images : .videos
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        
        return picker
    }
    
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard !results.isEmpty else { return }
            
            for result in results {
                let itemProvider = result.itemProvider
                
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
                        if let image = object as? UIImage {
                            DispatchQueue.main.async {
                                self?.parent.getUIImage?(image)
                            }
                        }
                    }
                }
                
                if itemProvider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
                    
                    itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { url, error in
                        
                        itemProvider.loadItem(forTypeIdentifier: UTType.movie.identifier, options: [:]) { [self] (videoURL, error) in
                            
                            print("url is: \(videoURL)")
                            
                            DispatchQueue.main.async {
                                if let url = videoURL as? URL {
                                    self.parent.getUrlVideo?(url)
                                    
                                    print("url is: \(url)")
                                }
                            }
                        }
                    }
                }
                
            }
        }
    }
    
}

enum TypePicker {
    case video, image
}
