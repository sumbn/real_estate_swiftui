//
//  AllProjectView.swift
//  DefaultProject
//
//  Created by daktech on 6/24/23.
//

import SwiftUI

struct AllProjectView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel : AllProjectViewModel
    
    let listCategory = ["Biệt thự, liền kề","Khu đô thị mới","Khu nghỉ dưỡng", "Khu dân cư", "Cao ốc văn phòng", "Trung tâm thương mại"]
    
    init(){
        let container = DependencyContainer()
        _viewModel = StateObject(wrappedValue: AllProjectViewModel(firestore: container.firestoreService))
    }
    
    var body: some View {
        VStack(spacing: 0){
            
            HStack(spacing: 0){
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.backward")
                    }
                    .foregroundColor(Color(hex: "#072331"))
                }
                .padding(.trailing, 12)
                
                HStack(spacing: 0){
                    Button {
                        viewModel.searchProject()
                    } label: {
                        Image("SearchHome")
                    }
                    .padding(.horizontal, 10)
                    
                    TextField("Tìm kiếm dự án", text: $viewModel.search)
                        .font(.custom(workSansBoldFont, size: 15))
                }
                .frame(maxWidth: .infinity, maxHeight: 45)
                .background {
                    RoundedRectangle(cornerRadius: 9)
                        .fill(Color("Background6"))
                }
                
                Image("NotifyHome")
                    .padding(.leading, 18)
                    .padding(.trailing, 4)
                
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 10)
            
            if viewModel.search == "" {
                Image("BackgroundAllProject")
                
                Rectangle()
                    .frame(height: 16)
                    .foregroundColor(Color("Background7"))
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 42){
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack (spacing: 28){
                                ForEach(listCategory, id: \.self) {
                                    CategoryAllProjectItemView(category: $0)
                                }
                            }
                        }
                    }
                    
                    VStack {
                        HStack{
                            Text("Dự án mua bán gần đây")
                                .font(.custom(workSansBoldFont, size: 17))
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Text("Xem thêm")
                                    .foregroundColor(Color("Text3"))
                            }
                        }
                        .padding(.trailing, 20)
                        .frame(maxWidth: .infinity)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 30) {
                                ForEach(viewModel.listPurchasePost, id: \.id) { post in
                                    
                                    NavigationLink {
                                        ProjectDetailView(post: post)
                                    } label: {
                                        ProjectInAllProjectItemView(post: post)
                                    }

                                    
                                }
                            }
                        }
                        .frame(maxHeight: 360)
                        
                        HStack{
                            Text("Dự án cho thuê gần đây")
                                .font(.custom(workSansBoldFont, size: 17))
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Text("Xem thêm")
                                    .foregroundColor(Color("Text3"))
                            }
                        }
                        .padding(.trailing, 20)
                        .frame(maxWidth: .infinity)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 30) {
                                ForEach(viewModel.listLeasingPost, id: \.id) { post in
                                    ProjectInAllProjectItemView(post: post)
                                }
                            }
                        }
                        .frame(maxHeight: 360)
                    }
                    
                }
                .padding(.top, 25)
                .padding(.leading, 20)
            } else {
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {
                        
                        if viewModel.sortedListSearched.count > 0 {
                            Text("\(viewModel.sortedListSearched.count) dự án phù hợp")
                                .font(.custom(workSansBoldFont, size: 17))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(20)
                        }
                        
                        ForEach(viewModel.sortedListSearched, id: \.id) { post in
                            ProjectInAllProjectItemView(post: post)
                        }
                    }
                }
            }
        }
        .onAppear{
            viewModel.getPurchasingProjects()
            viewModel.getLeasingProjects()
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct AllProjectView_Previews: PreviewProvider {
    static var previews: some View {
        AllProjectView()
    }
}
