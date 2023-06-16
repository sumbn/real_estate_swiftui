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
                    
                    HStack(spacing: 0){
                        Text(realEstateCategory)
                            .padding(.vertical, 12)
                            .padding(.leading, 12)
                            .padding(.trailing, 6)
                        
                        Menu {
                            ForEach(listOptions, id: \.self) { string in
                                Button(string) {
                                    realEstateCategory = string
                                }
                            }
                        } label: {
                            Image("TriangleDownHome")
                        }
                        
                        Button {
                            
                        } label: {
                            Image("SearchHome")
                        }
                        .padding(.horizontal, 10)
                        
                        TextField("Tìm kiếm nhà, đất, khu vực", text: $search)
                            .font(.custom("Work Sans Bold", size: 15))
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                            ForEach(viewModel.listPurchasingRealEstate, id: \.id) { post in
                                RealEstateHomeView(post: post)
                            }
                        }
                        
                        
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
                
                VStack(spacing: 16){
                    Image("BackgroundHome")
                    
                    VStack(spacing: 0) {
                        HStack(spacing: 66.5) {
                            VStack {
                                Button {
                                    
                                } label: {
                                    Image("IconPurchaseHome")
                                }
                                
                                Text("Mua bán")
                                    .font(.custom("Work Sans Bold", size: 15))
                            }
                            
                            VStack {
                                Button {
                                    
                                } label: {
                                    Image("IconLeaseHome")
                                }
                                
                                Text("Cho thuê")
                                    .font(.custom("Work Sans Bold", size: 15))
                            }
                            
                            VStack {
                                Button {
                                    
                                } label: {
                                    Image("IconProjectHome")
                                }
                                
                                Text("Dự án")
                                    .font(.custom("Work Sans Bold", size: 15))
                            }
                        }
                        .padding(.top, 46)
                        .padding(.bottom, 33)
                        
                        HStack{
                            Text("Mua bán bất động sản")
                                .font(.custom("Work Sans Bold", size: 17))
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Text("Xem thêm")
                                    .foregroundColor(Color("Text3"))
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 16)
                        
                        
                    }
                    .frame(maxWidth: .infinity)
                    .background {
                        Color.white
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .background(Color("Background7"))
                
                Button("Test") {
                    viewModel.getAllPurchasingPost()
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ShareModel())
    }
}
