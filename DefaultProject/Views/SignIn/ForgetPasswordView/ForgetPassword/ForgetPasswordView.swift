//
//  ForgetPasswordView.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/12/23.
//
//
import SwiftUI

struct ForgetPasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var coordinator: ShareModel
    @ObservedObject var viewModel: ForgetPasswordViewModel
    
    @State private var phoneNumber: String = "Nhập sđt của bạn để lấy lại mật khẩu"
    @State var isActive = false
    
    @State var isFirstClick = true
    
    @State var isChangeScreen = false
    
    
    
    init() {
        let sendSmsOtpService = AuthService(signInService: SendSmsOTPService())
        self.viewModel = ForgetPasswordViewModel(authService: sendSmsOtpService)
    }
    
    var body: some View {
        
            VStack(spacing: 0){
                
                NavigationLink(destination: PhoneVerificationView(), isActive: $isChangeScreen) {
                }
                
                HStack{
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack{
                            Image(systemName: "chevron.backward")
                               
                            
                            Text("Lấy lại mật khẩu")
                                .font(.custom("Work Sans Bold", size: 17))
                        }
                        .foregroundColor(Color("Background3"))
                    }
                    

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                OutlineTextfieldView(str: $phoneNumber, isActive: $isActive, label: "Số điện thoại", modifier: 9)
                    .onTapGesture {
                        if isFirstClick {
                            isActive = true
                            phoneNumber = ""
                            isFirstClick = false
                        }
                    }
                    .padding(.top, 40)
                
                Button {
                    let phone : String = "+84 \(phoneNumber)"
//                    let phone = "+1 650-555-1111"
                    viewModel.sendOtpToPhoneNumber(phoneNumber: phone) { authen in
                        coordinator.userSession = authen
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isChangeScreen = true
                        }
                       
                    }
                } label: {
                    Text("Đồng ý")
                        .font(.custom("Work Sans", size: 17))
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .accentColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 24)
                
                
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationBarBackButtonHidden(true)
            .padding(.horizontal, 20)
        
    }
}

struct ForgetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordView()
    }
}



