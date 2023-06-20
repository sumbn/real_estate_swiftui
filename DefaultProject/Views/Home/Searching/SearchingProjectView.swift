//
//  SearchingProjectView.swift
//  DefaultProject
//
//  Created by daktech on 6/19/23.
//

import SwiftUI

struct SearchingProjectView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var search = ""
    @State var address = "Ho Chi Minh"
    let viewModel : SearchingProjectViewModel
    
    init(){
        let container = DependencyContainer()
        viewModel = SearchingProjectViewModel(firestore: container.firestoreService)
    }
    
    @State var listSelected = [String]()
    
    var body: some View {
        VStack{
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
                        
                    } label: {
                        Image("SearchHome")
                    }
                    .padding(.horizontal, 10)
                    
                    TextField("Tìm kiếm nhà, đất, khu vực", text: $search)
                        .font(.custom("Work Sans Bold", size: 15))
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
            
            HStack{
                
                Image("SearchingLocationIcon")
                
                Text("Khu vực:")
                    .font(.custom("Work Sans", size: 15))
                    .foregroundColor(Color("Text6"))
                
                Text(address)
                    .padding(.vertical, 12)
                    .padding(.leading, 12)
                    .padding(.trailing, 6)
                    .frame(maxWidth: 235, alignment: .leading)
                
                Menu {
                    ForEach(viewModel.listProvince, id: \.self) { add in
                        Button(add.province ?? "") {
                            address = add.province ?? ""
                        }
                    }
                    
                } label: {
                    Image("TriangleDownHome")
                }
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView (.horizontal){
                
                LazyHStack {
                    Button {
                        viewModel.test()
                    } label: {
                        HStack(spacing: 4) {
                            Image("SearchingFilterIcon")
                            Text("Lọc")
                                .foregroundColor(Color.black)
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 9)
                        .background {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color("Text6").opacity(0.7))
                                
                        }
                    }
                    
                    NavigationLink {
                        TypeOfRealEstateView(listName: ["Biệt thự, liền kề","Khu đô thị mới","Khu nghỉ dưỡng", "Khu dân cư", "Cao ốc văn phòng", "Trung tâm thương mại"], listSelected: listSelected) { [self] list in
                            listSelected = list
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Text("Biệt thự, liền kề")
                                .foregroundColor(Color.black)
                            Image("TriangleDownHome")
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 9)
                        .background {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color("Text6").opacity(0.7))
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack(spacing: 4) {
                            Text("Giá mua bán")
                                .foregroundColor(Color.black)
                            Image("TriangleDownHome")
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 9)
                        .background {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color("Text6").opacity(0.7))
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack(spacing: 4) {
                            Text("Giá +")
                                .foregroundColor(Color.black)
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 9)
                        .background {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color("Background8"))
                                
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack(spacing: 4) {
                            Text("Dự án ")
                                .foregroundColor(Color.black)
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 9)
                        .background {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color("Background8"))
                        }
                    }
                }
            }
            .frame(height: 35, alignment: .leading)
            .padding(.leading, 20)
            .padding(.bottom, 16)
            
            Rectangle()
                .frame(height: 16)
                .foregroundColor(Color("Background7"))
                
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct SearchingProjectView_Previews: PreviewProvider {
    static var previews: some View {
        SearchingProjectView()
    }
}
