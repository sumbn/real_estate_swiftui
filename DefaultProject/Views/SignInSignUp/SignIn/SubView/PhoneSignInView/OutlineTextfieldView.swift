//
//  OutlineTextfieldView.swift
//  AuthenWithFirebases
//
//  Created by daktech on 5/22/23.
//

import SwiftUI

struct OutlineTextfieldView: View {
    @Binding var str : String
    @State var isEdit = false
    @Binding var isActive: Bool 
    
    var label : String
    var modifier : Double = 8
    var body: some View {
        ZStack(alignment: isEdit || str != "" ? .topLeading : .leading){
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.08)), lineWidth: 1)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background {
                    Color.clear
                }
            
            Text(label)
                .frame(width: CGFloat(label.count) * modifier , height: 20)
                .font(.custom(workSansFont, size: 17))
                .multilineTextAlignment(.leading)
                .background(.white)
                .padding(.leading, 10)
                .offset(y: isEdit || str != "" ? -10 : 0)
        }
        .overlay(alignment: .center, content: {
            TextField("", text: $str, onEditingChanged: { bool in
                withAnimation {
                    self.isEdit = bool
                }
                
            })
            .font(.custom(workSansFont, size: 17))
            .textFieldStyle(.plain)
            .foregroundColor(.black)
            .opacity(isActive ? 1 : 0.5)
            .background {
                Color.clear
            }
            .padding(.horizontal)
        })
       
    }
}

struct OutlineTextfieldView_Previews: PreviewProvider {
    static var previews: some View {
        OutlineTextfieldView(str: .constant(""), isActive: .constant(true) , label: "Số điện thoại")
    }
}
