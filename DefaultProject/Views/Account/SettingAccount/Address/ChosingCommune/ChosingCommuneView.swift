//
//  ChosingCommuneView.swift
//  DefaultProject
//
//  Created by daktech on 6/12/23.
//

import SwiftUI

struct ChosingCommuneView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let listCommune : [Commune]
    
    let selectedItem: Int?
    let getResultCommune: (Int) -> Void
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.backward")
                        Text("Chọn Phường/ xã/ thị trấn")
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
                ForEach(Array(listCommune.enumerated()), id: \.element.id) { index, commune in
                    Button {
                        getResultCommune(index)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Text(commune.name)
                            if selectedItem == index {
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

struct ChosingCommuneView_Previews: PreviewProvider {
    static var previews: some View {
        ChosingCommuneView(listCommune: [], selectedItem: nil){ index in
            
        }
    }
}
