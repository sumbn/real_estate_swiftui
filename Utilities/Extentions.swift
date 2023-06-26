//
//  Extentions.swift
//  DefaultProject
//
//  Created by daktech on 6/10/23.
//

import Foundation

extension Bundle {
    
    func decode<T : Codable>(type: T.Type , from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("No file name: \(file) in Bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load")
        }
        
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(_, _) {
            fatalError("Failed keyNotFound")
        } catch DecodingError.typeMismatch(_, _){
            fatalError("Failed typeMismatch")
        } catch DecodingError.dataCorrupted( _){
            fatalError("Wrong Json")
        } catch DecodingError.valueNotFound(_, _){
            fatalError("Failed valueNotFound")
        } catch {
            fatalError("Failde to decode")
        }
    }
}

extension Int {
    var changePriceToString : String {
        let billion = 1_000_000_000
        let million = 1_000_000
        
        if self >= billion {
            let billions = Double(self) / Double(billion)
            return String(format: "%.1f tỷ", billions)
        } else if self >= million {
            let millions = Double(self) / Double(million)
            return String(format: "%.1f triệu", millions)
        } else {
            return "\(self)"
        }
    }
}

extension Date {
    var dateFormatWithTimezone7: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 7 * 60 * 60)
        return dateFormatter.string(from: self)
    }
}
