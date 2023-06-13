//
//  ChosingDistrictView.swift
//  DefaultProject
//
//  Created by daktech on 6/10/23.
//

import SwiftUI

struct ChosingDistrictView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let listDistrict : [District]
    
    let selectedItem: String?
    let getResultDistrict : (District) -> Void
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.backward")
                        Text("Chọn Quận/ huyện/ thị xã")
                            .font(.custom("Work Sans", size: 17))
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
                ForEach(Array(listDistrict.enumerated()), id: \.element.id) { index, district in
                    Button {
                        getResultDistrict(district)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Text(district.name)
                            if selectedItem == district.name {
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

struct ChosingDistrictView_Previews: PreviewProvider {
    static var previews: some View {
        ChosingDistrictView(listDistrict: [], selectedItem: nil) { index in
            
        }
    }
}
