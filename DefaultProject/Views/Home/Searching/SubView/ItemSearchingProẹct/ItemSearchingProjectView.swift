//
//  ItemSearchingProjectView.swift
//  DefaultProject
//
//  Created by daktech on 6/20/23.
//

import SwiftUI
import Kingfisher

struct ItemSearchingProjectView: View {
    let post : PostModel
    @ObservedObject var viewModel : ItemSearchingProjectViewModel
    
    init(post: PostModel) {
        self.post = post
        let container = DependencyContainer()
        self.viewModel = ItemSearchingProjectViewModel(fireStore: container.firestoreService)
    }
    
    var body: some View {
        VStack(spacing: 4){

            if let url = URL(string: post.imageURLs?.first ?? ""){
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxHeight: 240)
                    .cornerRadius(6)
            }

            if let title = post.postTitle {
                Text(title)
                    .font(.custom("Work Sans Bold", size: 17))
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 9)
                    .padding(.bottom,4)
            }


            if let price = post.price, let area = post.area {
                Text("Từ \(readNumber(price/area))/m\u{00B2}")
                    .font(.custom("Work Sans Bold", size: 15))
                    .foregroundColor(Color("Text5"))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            if let category = post.category {
                HStack {
                    Image("CategoryFilterIcon")
                    Text(category)
                        .font(.custom("Work Sans", size: 15))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            if let province = post.province_city, let district = post.district, let commune = post.commune {
                HStack {
                    Image("LocationFilterIcon")
                    Text(commune + ", " + district + ", " + province)
                        .lineLimit(1)
                        .font(.custom("Work Sans", size: 15))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            if let des = post.postDescription {
                Text(des)
                    .font(.custom("Work Sans", size: 13))
                    .lineLimit(3)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            HStack {
                Image("ShowNameUserFilterIcon")

                Text(viewModel.nameUser)
                    .font(.custom("Work Sans Bold", size: 13))
            }
            .frame(maxWidth: .infinity, alignment: .leading)

        }
        .onAppear{
            viewModel.getNameUserFromPosting(uid: post.uid ?? "")
        }
        .frame(maxWidth: 390, alignment: .top)
    }
}

struct ItemSearchingProjectView_Previews: PreviewProvider {
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
        return ItemSearchingProjectView(post: post)
    }
}
