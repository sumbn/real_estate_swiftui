//
//  Ultilities.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/10/23.
//

import Foundation
import UIKit

typealias AuthenticationResult = Result<AuthenticationModel, Error>

final class Utilities {
    
    static let shared = Utilities()
    private init(){
        
    }
    
    
    func rootViewController(controller: UIViewController? = nil) -> UIViewController? {
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }

        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }

        return root
    }
}

