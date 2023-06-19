//
//  SearchingProjectViewModel.swift
//  DefaultProject
//
//  Created by daktech on 6/19/23.
//

import Foundation
class SearchingProjectViewModel {
    
    var listProvince : [AddressModel] {
        let list = Bundle.main.decode(type: [Province].self, from: "fakeJson.json")
        return list.map { province in
            AddressModel(province: province.name )
        }
    }
    

}
