//
//  ChosingProvince.swift
//  DefaultProject
//
//  Created by daktech on 6/10/23.
//

import SwiftUI

struct ChosingProvince: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let listProvince : [Province]
    let selectedItem: String?
    
    let getResultProvince: (Province) -> Void
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.backward")
                        Text("Chọn Tỉnh/ thành phố")
                            .font(.custom(workSansFont, size: 17))
                            .bold()
                    }
                    .foregroundColor(Color(hex: "#072331"))
                }
            }
            .padding(.vertical, 18)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white)
            .padding(.bottom, 16)
            
            List {
                ForEach(Array(listProvince.enumerated()), id: \.element.id) { index, province in
                    
                   
                        Button {
                            getResultProvince(province)
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            HStack{
                                Text(province.name)
                                if selectedItem == province.name {
                                    Image(systemName: "checkmark")
                                }
                            }
                            
                        }
                        
                        
                    
                   
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct ChosingProvince_Previews: PreviewProvider {
    static var previews: some View {
        ChosingProvince(listProvince: [], selectedItem: nil) { index in
            
        }
    }
}
