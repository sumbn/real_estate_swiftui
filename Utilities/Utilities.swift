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

func generateUniqueString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMddHHmmss"
    
    let currentTimeString = formatter.string(from: Date())
    let randomString = UUID().uuidString
    
    let uniqueString = currentTimeString + randomString
    return uniqueString
}


func convertDateToString(from date: Date, dateFormat : String = "dd/MM/yyyy") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat =  dateFormat
    
    return dateFormatter.string(from: date)
}

func convertStringToDate(from string: String, dateFormat: String = "dd/MM/yyyy") -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    return dateFormatter.date(from: string)
}
