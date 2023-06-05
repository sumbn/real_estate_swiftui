//
//  ImagePicker.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/30/23.
//

import Foundation
import SwiftUI

struct ImagePicker : UIViewControllerRepresentable {
    
    var typePicker: TypePicker
    var getUrlVideo: ((URL?)-> Void)?
    var getUIImage:((UIImage) -> Void)?
    
    
    private let controller = UIImagePickerController()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        controller.delegate = context.coordinator
        
        switch typePicker {
        case .image:
            controller.mediaTypes = ["public.image"]
        case . video:
            controller.mediaTypes = ["public.movie"]
        }
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[.originalImage] as? UIImage {
                parent.getUIImage?(image)
            }
            
            if let videoURL = info[.mediaURL] as? URL {
                parent.getUrlVideo?(videoURL)
            }
            
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
    
}

enum TypePicker {
    case video, image
}
