//
//  RealEstateHomeView.swift
//  DefaultProject
//
//  Created by daktech on 6/16/23.
//

import SwiftUI
import Kingfisher

struct ItemRealEstateHomeView: View {
    let post : PostModel
    var body: some View {
        VStack(spacing: 0){
            
            if let url = URL(string: post.imageURLs?.first ?? ""){
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxHeight: 106)
                    .cornerRadius(6)
            }
            
            if let title = post.postTitle {
                Text(title)
                    .font(.custom("Work Sans", size: 13))
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    .padding(.top, 9)
                    .padding(.bottom,4)
            }
            
            HStack(spacing: 8){
                if let price = post.price {
                    Text(String(price))
                        .font(.custom("Work Sans", size: 15))
                        .foregroundColor(Color("Text5"))
                }
                
                Image("DotHome")
                
                if let area = post.area {
                    Text(String(area))
                        .font(.custom("Work Sans", size: 13))
                        .opacity(0.48)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: 188, alignment: .top)
    }
}

struct RealEstateHomeView_Previews: PreviewProvider {
    static var previews: some View {
        var post = PostModel()
        post.imageURLs = ["https://firebasestorage.googleapis.com:443/v0/b/fir-authentication-7b6d9.appspot.com/o/images%2F20230615150931DEC01F05-0FEB-4279-AD0F-9783AD603D4B.jpg?alt=media&token=26fe76c2-2805-47fc-b66c-039e67f422de"]
        post.postTitle = "Siêu rẻ siêu rẻ, cần bán gấp lô đất 200m2"
        post.price = 419000000
        post.area = 200
        return ItemRealEstateHomeView(post: post)
    }
}
