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
    @State private var displayName: String = "Nhập vào tên tài khoản"
    @State var isActive: Bool = false
    
    @State var isFirstClick = true
    
    @ObservedObject var viewModel : PhoneAuthViewModel
    
    @State var isChangeScreen = false
    
    init() {
        let sendSmsOtpService = AuthService(signInService: SendSmsOTPService())
        self.viewModel = PhoneAuthViewModel(authService: sendSmsOtpService)
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            NavigationLink(destination: PhoneVerificationView(), isActive: $isChangeScreen) {
            }
            
            OutlineTextfieldView(str: $phoneNumber, isActive: .constant(true), label: "Số điện thoại", modifier: 9)
                .padding(.bottom, 25)
            OutlineTextfieldView(str: $displayName, isActive: $isActive, label: "Tên hiển thị", modifier: 9)
                .onTapGesture {
                    if isFirstClick{
                        displayName = ""
                        isActive = true
                        isFirstClick = false
                    }
                }
                .padding(.bottom, 20)
            
            Button {
                
                let phone : String = "+84 \(phoneNumber)"
//                                    let phone = "+1 650-555-1111"
                viewModel.sendOtpToPhoneNumber(phoneNumber: phone, name: displayName) { authen in
                    coordinator.userSession = authen
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isChangeScreen = true
                    }
                }
                
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

