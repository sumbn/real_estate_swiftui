//
//  ChosingProvince.swift
//  DefaultProject
//
//  Created by daktech on 6/10/23.
//

import SwiftUI

struct ChosingProvince: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.backward")
                        Text("Chọn Tỉnh/ thành phố")
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
            
            Button {
                let list = Bundle.main.decode(type: [Province].self, from: "fakeJson.json")
                dump(list)
            } label: {
                Text("Test")
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct ChosingProvince_Previews: PreviewProvider {
    static var previews: some View {
        ChosingProvince()
    }
}
