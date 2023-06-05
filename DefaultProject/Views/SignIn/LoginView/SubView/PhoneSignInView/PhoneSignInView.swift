//
//  PhoneSignInView.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/11/23.
//

import SwiftUI

struct PhoneSignInView: View {
    @EnvironmentObject var coordinator : ShareModel
    
    @State private var phoneNumber: String = ""
    @State private var password: String = "Mật khẩu của bạn"
    @State var isActive: Bool = false
    
    @State var isFirstClick = true
    
    var body: some View {
        
        
        VStack(spacing: 0) {
            OutlineTextfieldView(str: $phoneNumber, isActive: .constant(true), label: "Số điện thoại", modifier: 9)
                .padding(.bottom, 25)
            OutlineTextfieldView(str: $password, isActive: $isActive, label: "Mật khẩu", modifier: 10)
                .onTapGesture {
                    if isFirstClick{
                        password = ""
                        isActive = true
                        isFirstClick = false
                    }
                }
                .padding(.bottom, 20)
            
            Button {
                
            } label: {
                Text("Đăng nhập")
                    .font(.custom("Work Sans", size: 17))
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 56)
                    .accentColor(Color.white)
                    .background(Color(hex: "#5276F0"))
                    .cornerRadius(10)
            }
            
        }
        
        
    }
}

struct PhoneSignInView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneSignInView()
    }
}

