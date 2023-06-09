//
//  SignUpSuccessView.swift
//  AuthenWithFirebases
//
//  Created by daktech on 5/23/23.
//

import SwiftUI

struct SignUpSuccessView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var coordinator: ShareModel
    
   
    
    var body: some View {
        VStack(spacing: 0){
            HStack{
                
               
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.backward")
                        Text("Đăng ký thành công")
                            .font(.custom("Work sans", size: 17))
                            .bold()
                    }
                    .foregroundColor(Color("Background3"))

                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 200)
            
            Image(systemName: "checkmark.circle")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(Color("Icon"))
                .padding(.bottom, 16)
            
            Text("Chúc mừng bạn đã đăng ký thành công")
                .font(.custom("Work sans", size: 24))
                .bold()
                .multilineTextAlignment(.center)
            
            Text("Đăng nhập để trải nghiệm dịch vụ")
                .font(.custom("Work sans", size: 15))
                .padding(.vertical, 16)
            
            Button {
                coordinator.isNotAuth = false
            } label: {
                Text("Trải nghiệm ngay")
                    .font(.custom("Work sans", size: 17))
                    .foregroundColor(.white)
                    .bold()
                    .padding(.vertical, 16)
                    .padding(.horizontal, 39)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("Text3"))
                    }
            }
            
        }
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden(true)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct SignUpSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpSuccessView()
    }
}
