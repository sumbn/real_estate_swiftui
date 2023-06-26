//
//  MainView.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/11/23.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
    @EnvironmentObject var shareModel: ShareModel
    
    
    @StateObject var viewModel : HomeViewModel = HomeViewModel(firestore: DependencyContainer().firestoreService)
    @State var realEstateCategory = "Mua bán"
    let listOptions = ["Mua bán", "Cho thuê"]
    
    @State var search : String = ""
    
    
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 0) {
                HStack(spacing: 0){
                    
//                    HStack(spacing: 0){
//                        Text(realEstateCategory)
//                            .padding(.vertical, 12)
//                            .padding(.leading, 12)
//                            .padding(.trailing, 6)
//
//                        Menu {
//                            ForEach(listOptions, id: \.self) { string in
//                                Button(string) {
//                                    realEstateCategory = string
//                                }
//                            }
//                        } label: {
//                            Image("TriangleDownHome")
//                        }
//
//                        Button {
//
//                        } label: {
//                            Image("SearchHome")
//                        }
//                        .padding(.horizontal, 10)
//
//                        TextField("Tìm kiếm nhà, đất, khu vực", text: $search)
//                            .font(.custom(workSansBoldFont, size: 15))
//
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: 45)
//                    .background {
//                        RoundedRectangle(cornerRadius: 9)
//                            .fill(Color("Background6"))
//                    }
                    
                    
                    NavigationLink {
                        SearchingProjectView()
                    } label: {
                        Image("SearchHome")
                    }
                    .padding(.horizontal, 10)
                    
                    Spacer()
                    
                    Image("NotifyHome")
                        .padding(.leading, 18)
                        .padding(.trailing, 4)
                    
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
                
                VStack(spacing: 16){
                    
                    ScrollView {
                        Image("BackgroundHome")
                        
                        VStack(spacing: 0) {
                            HStack(spacing: 66.5) {
                                VStack {
                                    Button {
                                        
                                    } label: {
                                        Image("IconPurchaseHome")
                                    }
                                    
                                    Text("Mua bán")
                                        .font(.custom(workSansBoldFont, size: 15))
                                }
                                
                                VStack {
                                    Button {
                                        
                                    } label: {
                                        Image("IconLeaseHome")
                                    }
                                    
                                    Text("Cho thuê")
                                        .font(.custom(workSansBoldFont, size: 15))
                                }
                                
                                VStack {
                                    NavigationLink {
                                       AllProjectView()
                                    } label: {
                                        Image("IconProjectHome")
                                    }
                                    
                                    Text("Dự án")
                                        .font(.custom(workSansBoldFont, size: 15))
                                }
                            }
                            .padding(.top, 46)
                            .padding(.bottom, 33)
                            
                            
                            HStack{
                                Text("Mua bán bất động sản")
                                    .font(.custom(workSansBoldFont, size: 17))
                                Spacer()
                                
                                Button {
                                    
                                } label: {
                                    Text("Xem thêm")
                                        .foregroundColor(Color("Text3"))
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 16)
                            
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                                ForEach(viewModel.listPurchasingRealEstate, id: \.id) { post in
                                    ItemRealEstateHomeView(post: post)
                                }
                            }
                            
                            HStack{
                                Text("Cho thuê bất động sản")
                                    .font(.custom(workSansBoldFont, size: 17))
                                Spacer()
                                
                                Button {
                                    
                                } label: {
                                    Text("Xem thêm")
                                        .foregroundColor(Color("Text3"))
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 43)
                            .padding(.bottom, 16)
                            
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                                ForEach(viewModel.listLeaseRealEstate, id: \.id) { post in
                                    ItemRealEstateHomeView(post: post)
                                }
                            }
                            
                            .padding(.bottom, 29)
                        }
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity)
                        .background {
                            Color.white
                        }
                        
                        VStack(spacing: 0){
                            HStack{
                                Text("Dự án được quan tâm")
                                    .font(.custom(workSansBoldFont, size: 17))
                                Spacer()
                                
                                Button {
                                    
                                } label: {
                                    Text("Xem thêm")
                                        .foregroundColor(Color("Text3"))
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 29)
                            .padding(.bottom, 16)
                            .padding(.trailing, 20)
                            
                            ScrollView(.horizontal) {
                                LazyHStack{
                                    ForEach(viewModel.listPurchasingRealEstate, id: \.id) { post in
                                        ItemRealEstateHomeView(post: post)
                                            .frame(width: 188, height: 170)
                                    }
                                }
                            }
                            .padding(.bottom, 19)
                        }
                        .padding(.leading, 20)
                        
                        .background {
                            Color.white
                        }
                    }
                }
                .padding(.bottom, 60)
                .frame(maxHeight: .infinity, alignment: .top)
                .background(Color("Background7"))
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .onAppear{
                if viewModel.listLeaseRealEstate.count == 0 {
                    viewModel.getAllPurchasingPost()
                    viewModel.getAllLeasePost()
                }
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ShareModel())
    }
}
