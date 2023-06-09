//
//  GetPostView.swift
//  AuthenWithFirebase
//
//  Created by daktech on 6/3/23.
//

import SwiftUI

struct GetAllPostView: View {
    
    @StateObject private var getAllPostViewModel = GetAllPostViewModel(fireStoreService: FirestoreService())
        
        var body: some View {
            ScrollView {
                VStack {
                    ForEach(getAllPostViewModel.list, id: \.id) { post in
                        NavigationLink(destination: PostItemView(postModel: post)) {
                            Text(post.id)
                                .font(.custom("Work Sans", size: 17))
                                .bold()
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.blue)
                                }
                                .padding(.horizontal, 20)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .onAppear {
                getAllPostViewModel.getAllData()
            }
        }
}

struct GetPostView_Previews: PreviewProvider {
    static var previews: some View {
        GetAllPostView()
    }
}
