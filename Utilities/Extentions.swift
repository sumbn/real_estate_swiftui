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

extension String {
    func generateStringSequence() -> [String]{
        var sequences: [String] = []
        for i in 1...self.count{
            sequences.append(String(self.prefix(i)))
        }
        
        return sequences
    }
}
