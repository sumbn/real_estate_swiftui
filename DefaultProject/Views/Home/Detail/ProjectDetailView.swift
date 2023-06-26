//
//  ProjectDetailView.swift
//  DefaultProject
//
//  Created by daktech on 6/26/23.
//

import SwiftUI
import Kingfisher

struct ProjectDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let post : PostModel
    var body: some View {
        LazyVStack {
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.backward")
                        Text("Dự án")
                            .font(.custom(workSansFont, size: 17))
                            .bold()
                    }
                    .foregroundColor(Color(hex: "#072331"))
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 18)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white)
            .padding(.bottom, 16)
            
            TabView {
                ForEach(post.imageURLs ?? [], id: \.self) { url in
                    if let url = URL(string: url) {
                        KFImage(url)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 241)
                    }
                }
            }
            .frame(height: 300)
            .tabViewStyle(PageTabViewStyle())
            
            VStack {
                Text(post.postTitle ?? "")
                    .font(.custom(workSansBoldFont, size: 17))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
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
                    .foregroundColor(Color.black)
                    .opacity(0.6)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.horizontal, 20)
            
            Divider()
            
            
            
            
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct ProjectDetailView_Previews: PreviewProvider {
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
        return ProjectDetailView(post: post)
    }
}
