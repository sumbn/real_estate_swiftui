//
//  CategoryAllProjectItemView.swift
//  DefaultProject
//
//  Created by daktech on 6/24/23.
//

import SwiftUI

struct CategoryAllProjectItemView: View {
    let category : String
    var body: some View {
        VStack {
            
            ZStack{
                
                RoundedRectangle(cornerRadius: 17)
                    .fill(Color("Background10"))
                    .frame(width: 58, height: 58)
                
                if category == "Biệt thự, liền kề" {
                    Image("CategoryFilterIcon")
                } else if category == "Khu đô thị mới" {
                    Image("CategoryFilterIcon3")
                } else if category == "Khu nghỉ dưỡng" {
                    Image("CategoryFilterIcon")
                } else if category == "Khu dân cư" {
                    Image("CategoryFilterIcon5")
                } else if category == "Cao ốc văn phòng" {
                    Image("CategoryFilterIcon6")
                } else {
                    Image("CategoryFilterIcon4")
                }
            }
            
            Text(category)
                .font(.custom(workSansBoldFont, size: 15))
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(width: 64, height: 102)
    }
}

struct CategoryAllProjectItemView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryAllProjectItemView(category: "Biệt thự, liền kề")
    }
}
