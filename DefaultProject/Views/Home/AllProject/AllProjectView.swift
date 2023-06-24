//
//  AllProjectView.swift
//  DefaultProject
//
//  Created by daktech on 6/24/23.
//

import SwiftUI

struct AllProjectView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var search = ""
    
    let listCategory = ["Biệt thự, liền kề","Khu đô thị mới","Khu nghỉ dưỡng", "Khu dân cư", "Cao ốc văn phòng", "Trung tâm thương mại"]
    
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
                        
                    } label: {
                        Image("SearchHome")
                    }
                    .padding(.horizontal, 10)
                    
                    TextField("Tìm kiếm dự án", text: $search)
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
                        Text("Dự án đang mở bán")
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
                    
                    
                    
                }
                
            }
            .padding(.top, 25)
            .padding(.leading, 20)
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
