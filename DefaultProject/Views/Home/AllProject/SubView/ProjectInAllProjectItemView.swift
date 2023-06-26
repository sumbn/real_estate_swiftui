//
//  ProjectBeingOpeningView.swift
//  DefaultProject
//
//  Created by daktech on 6/24/23.
//

import SwiftUI
import Kingfisher

struct ProjectInAllProjectItemView: View {
    
    let post: PostModel
    
    var body: some View {
        VStack(spacing: 4){

            if let url = URL(string: post.imageURLs?.first ?? ""){
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 283)
                    .cornerRadius(6)
            }

            if let title = post.postTitle {
                Text(title)
                    .font(.custom(workSansBoldFont, size: 17))
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 9)
                    .padding(.bottom,4)
            }


            if let price = post.price, let area = post.area {
                Text("Từ \((price/area).changePriceToString)/m\u{00B2}")
                    .font(.custom(workSansBoldFont, size: 15))
                    .foregroundColor(Color("Text5"))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            if let category = post.category {
                HStack {
                    if category == "Biệt thự, liền kề" {
                        Image("CategoryFilterIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    } else if category == "Khu đô thị mới" {
                        Image("CategoryFilterIcon3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    } else if category == "Khu nghỉ dưỡng" {
                        Image("CategoryFilterIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    } else if category == "Khu dân cư" {
                        Image("CategoryFilterIcon5")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    } else if category == "Cao ốc văn phòng" {
                        Image("CategoryFilterIcon6")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    } else {
                        Image("CategoryFilterIcon4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                    
                    Text(category)
                        .font(.custom(workSansFont, size: 15))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            if let province = post.province_city, let district = post.district, let commune = post.commune {
                HStack {
                    Image("LocationFilterIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        
                    Text(commune + ", " + district + ", " + province)
                        .lineLimit(1)
                        .font(.custom(workSansFont, size: 15))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            if let des = post.postDescription {
                
                HStack(alignment: .top) {
                    Image("DescriptionFilterIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    
                    Text(des)
                        .font(.custom(workSansFont, size: 15))
                        .lineLimit(2)
                        .lineSpacing(5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
            }


        }
        .frame(maxWidth: 283, alignment: .top)
    }
}

struct ProjectInAllProjectItemView_Previews: PreviewProvider {
    static var previews: some View {
        var post = PostModel()
        post.imageURLs = ["https://firebasestorage.googleapis.com:443/v0/b/fir-authentication-7b6d9.appspot.com/o/images%2F20230615150931DEC01F05-0FEB-4279-AD0F-9783AD603D4B.jpg?alt=media&token=26fe76c2-2805-47fc-b66c-039e67f422de"]
        post.postTitle = "Siêu rẻ siêu rẻ, cần bán gấp lô đất 200m2"
        post.price = 41_900_000_000
        post.area = 2_000
        post.category = "Trung tâm thương mại"
        post.province_city = "Hồ chí minh"
        post.district = "Quận 1"
        post.commune = "Phường 1"
        post.uid = "lw7PH29SnHQJrLRxysv2BA5kHbk1"
        post.postDescription = "ạdhkjfhj ạkdfhajksf adfjhasjhaf. adjkfhajkshf ậhkdhf adfjhasjkfh adfjhasjkdfh ấhdjfh adjfhajsdfh adfjhajkshfa ậhkasha aksdjf adjhfjkashdfjk adfjhasjkdhfahdsfjkhasdjfh"
        return ProjectInAllProjectItemView(post: post)
    }
}
