
import Foundation
import SwiftUI


extension String {
    func verifyUrl() -> Bool {
        let regex = "((http|https|ftp)://)?((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
        
    }
    
    func slice(from: String, to: String) -> String? {
        guard let fromRange = from.isEmpty ? startIndex..<startIndex : range(of: from) else { return nil }
        guard let toRange = to.isEmpty ? endIndex..<endIndex : range(of: to, range: fromRange.upperBound..<endIndex) else { return nil }
        
        return String(self[fromRange.upperBound..<toRange.lowerBound])
    }
    
    static func randomString(_ length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func toDate(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
    var integer: Int {
        return Int(self) ?? 0
    }
    
    var secondFromString : Int{
        let components: Array = self.components(separatedBy: ":")
        if components.count == 1{
            let hours = 0
            let minutes = 0
            let seconds = components[0].integer
            return Int((hours * 60 * 60) + (minutes * 60) + seconds)
        }
        else if components.count == 2{
            let hours = 0
            let minutes = components[0].integer
            let seconds = components[1].integer
            return Int((hours * 60 * 60) + (minutes * 60) + seconds)
        }
        else if components.count == 3{
            let hours = components[0].integer
            let minutes = components[1].integer
            let seconds = components[2].integer
            return Int((hours * 60 * 60) + (minutes * 60) + seconds)
        }
        else{
            return 0
        }
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options:
                                            [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
