//
//  GetPostView.swift
//  AuthenWithFirebase
//
//  Created by daktech on 6/3/23.
//

import SwiftUI

struct GetAllPostView: View {
    
    let getAllPostViewModel : GetAllPostViewModel
    
    @State var list = [PostModel]()
    
    init() {
        self.getAllPostViewModel = GetAllPostViewModel(fireStoreService: FirestoreService())
    }
    
    var body: some View {
        
        ScrollView {
            VStack{
                ForEach(list, id: \.id) { post in
                    NavigationLink {
                        PostItemView(postModel: post)
                    } label: {
                        Text(post.id)
                            .font(.custom("Work Sans", size: 17))
                            .bold()
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background{
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue)
                            }
                            .padding(.horizontal, 20)
                    }
                    
                }
            }
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .onAppear{
                getAllPostViewModel.getAllData { result in
                    switch result {
                    case .success(let list):
                        self.list = list
                    case .failure(let err) :
                        print(err)
                    }
                }
        }
        
    }
}

struct GetPostView_Previews: PreviewProvider {
    static var previews: some View {
        GetAllPostView()
    }
}
