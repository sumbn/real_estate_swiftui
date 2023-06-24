//
//  LoginView.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/10/23.


import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var shareModel: ShareModel
    var body: some View {
        NavigationView{
            
            VStack(spacing: 0){
                Text("Đăng nhập")
                    .font(.custom(workSansFont, size: 24))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 12)
                   
                Text("Đăng nhập để tiếp tục")
                    .font(.custom(workSansFont, size: 17))
                    .opacity(0.5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 31)
                
                PhoneSignInView()
                
//                NavigationLink {
//                    ForgetPasswordView()
//                } label: {
//                    Text("Quên mật khẩu")
//                        .font(.custom(workSans, size: 15))
//                        .foregroundColor(Color("Text3"))
//                }
//                .padding(.top, 16)
                
                
                Spacer()
                    .frame(maxHeight: 62)
                
                Text("hoặc sử dụng")
                    .font(.custom(workSansFont, size: 15))
                    .opacity(0.47)
                
                HStack(spacing: 18){
                    
                    FacebookSignInView{
                        switch $0{
                        case .success(let auth):
                            shareModel.userSession = auth
                            shareModel.isNotAuth = false
                        case .failure(let err):
                            print(err)
                        }
                    }
                    
                    GoogleSignInView{
                        switch $0{
                        case .success(let auth):
                            shareModel.userSession = auth
                            shareModel.isNotAuth = false
                        case .failure(let err):
                            print(err)
                        }
                    }
                    
                    AppleSignInView{
                        switch $0{
                        case .success(let auth):
                            shareModel.userSession = auth
                            shareModel.isNotAuth = false
                        case .failure(let err):
                            print(err)
                        }
                    }
                    
                }
                .padding(.vertical, 16)
                
                HStack(spacing: 0) {
                    Text("Chưa có tài khoản?")
                        .font(.custom(workSansFont, size: 15))
                        .foregroundColor(Color("Text4"))
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text(" Đăng ký ngay")
                            .font(.custom(workSansFont, size: 15))
                            .foregroundColor(Color("Text3"))
                    }
                }
                
                Spacer()
                
            }
            .navigationBarBackButtonHidden(true)
            .padding(.horizontal,20)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}





