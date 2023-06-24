//
//  SignUpView.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/11/23.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var coordinator: ShareModel
    @ObservedObject var viewModel: SignUpViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var isChangeScreen : Bool = false
    
    @State var name : String = "Nhập tên của bạn"
    @State var phoneNumber : String = "Nhập sđt của bạn"
    @State var passWord : String = "Tạo một mật khẩu có ít nhất 5 ký tự"
    
    @State var isActiveName: Bool = false
    @State var isActivePhoneNumber: Bool = false
    @State var isActivePassWord: Bool = false
    
    @State var isFirstClickName = true
    @State var isFirstClickPhoneNumber = true
    @State var isFirstClickPassWord = true
    
    init() {
        let sendSmsOtpService = AuthService(signInService: SendSmsOTPService())
        self.viewModel = SignUpViewModel(authService: sendSmsOtpService)
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            NavigationLink(destination: ConfirmPhoneNumberView(), isActive: $isChangeScreen) {
            }
            Text("Đăng ký")
                .font(.custom(workSansFont, size: 24))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 12)
            
            Text("Tạo tài khoản ngay")
                .font(.custom(workSansFont, size: 17))
                .opacity(0.3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 31)
            
            InputFormViews()
                .padding(.bottom, 20)
            
            Button {
//                let phone = "+1 650-555-1111"
                let phone = "+84 \(phoneNumber)"
                viewModel.sendOtpToPhoneNumber(phoneNumber: phone) { authen in
                    coordinator.userSession = authen
                    print("SignUpView \(coordinator.userSession)")
                    isChangeScreen = true
                }
                
            } label: {
                VStack{
                    Text("Đăng ký")
                        .font(.custom(workSansFont, size: 17))
                        .foregroundColor(Color.white)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(Color("Text3"))
                        .cornerRadius(10)
                }
            }
            .padding(.bottom, 16)
            
            Text("Bằng việc đăng ký, bạn đã đồng ý với")
                .font(.custom(workSansFont, size: 13))
            
            HStack {
                Button(action: {
                }) {
                    Text("Điều khoản sử dụng")
                        .font(.custom(workSansFont, size: 13))
                        .underline()
                        .foregroundColor(Color("Text3"))
                }
               
                
                
                Text("của chúng tôi")
                    .font(.custom(workSansFont, size: 13))
                    
            }
            .padding(.bottom, 62)
            
            
            
            Text("hoặc sử dụng")
                .font(.custom(workSansFont, size: 15))
                .opacity(0.47)
            
            HStack(spacing: 18){
                FacebookSignInView{
                    switch $0{
                    case .success(let auth):
                        coordinator.userSession = auth
                        coordinator.isNotAuth = false
                    case .failure(let err):
                        print(err)
                    }
                }
                
                GoogleSignInView{
                    switch $0{
                    case .success(let auth):
                        coordinator.userSession = auth
                        coordinator.isNotAuth = false
                    case .failure(let err):
                        print(err)
                    }
                }
                
                AppleSignInView{
                    switch $0{
                    case .success(let auth):
                        coordinator.userSession = auth
                        coordinator.isNotAuth = false
                        
                    case .failure(let err):
                        print(err)
                    }
                }
            }
            .padding(.vertical, 16)
            
            HStack {
                Text("Bạn đã có tài khoản?")
                    .font(.custom(workSansFont, size: 15))
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Đăng nhập ngay")
                        .font(.custom(workSansFont, size: 15))
                        .foregroundColor(Color("Text3"))
                }
            }
        }
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden(true)
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    func InputFormViews() -> some View {
        VStack(spacing: 25){
            OutlineTextfieldView(str: $name, isActive: $isActiveName, label: "Tên của bạn", modifier: 9.5)
                .onTapGesture {
                    if isFirstClickName{
                        isActiveName = true
                        name = ""
                        isFirstClickName = false
                    }
                   
                }
            
            OutlineTextfieldView(str: $phoneNumber, isActive: $isActivePhoneNumber, label: "Số điện thoại", modifier: 9)
                .onTapGesture {
                    if isFirstClickPhoneNumber {
                        isActivePhoneNumber = true
                        phoneNumber = ""
                        isFirstClickPhoneNumber = false
                    }
                }
            
            OutlineTextfieldView(str: $passWord, isActive: $isActivePassWord, label: "Mật khẩu", modifier: 10)
                .onTapGesture {
                    if isFirstClickPassWord{
                        isActivePassWord = true
                        passWord = ""
                        isFirstClickPassWord = false
                    }
                    
                }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
