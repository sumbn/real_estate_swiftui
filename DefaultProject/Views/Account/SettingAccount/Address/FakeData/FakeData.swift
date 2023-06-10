//
//  FakeData.swift
//  DefaultProject
//
//  Created by daktech on 6/10/23.
//

import Foundation

struct Province: Codable {
    let id: String
    let name: String
    let districts: [District]
}

struct District: Codable {
    let id: String
    let name: String
    let communes: [Commune]
}

struct Commune: Codable {
    let id: String
    let name: String
}

struct Test: Codable {
    let id: String
    let des: String
}

func loadFakeData() {
    guard let fileURL = Bundle.main.url(forResource: "fakeJson.json", withExtension: nil) else {
        print("Không tìm thấy file JSON")
        return
    }
    
    do {
        let data = try Data(contentsOf: fileURL)
        
        dump(data)
        let tests = try JSONDecoder().decode([Test].self, from: data)
        
        
        
        // Sử dụng dữ liệu fake tại đây
        for test in tests {
            print(test)
        }
        
    } catch {
        print("Lỗi khi đọc file JSON: \(error.localizedDescription)")
    }
}

