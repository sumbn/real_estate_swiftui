//
//  CreateNewPasswordView.swift
//  AuthenWithFirebases
//
//  Created by daktech on 5/22/23.
//

import SwiftUI

struct CreateNewPasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showDialog = false
    
    @State var isActiveTextField1 : Bool = false
    @State var isActiveTextField2 : Bool = false
    
    @State var isFirstClickPassword = true
    @State var isFirstClickConfirmPassword = true
    
    @State var password: String = "Tạo một mật khẩu có ít nhất 5 ký tự"
    @State var confirmPassword: String = "Nhập lại mật khẩu mới"
    
    @State var isChangeLoginView = false
    
    var body: some View {
        VStack(spacing: 0){
            
            HStack{
                NavigationLink(destination: LoginView(), isActive: $isChangeLoginView) {
                }
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.backward")
                        Text("Tạo mật khẩu mới")
                    }
                    .foregroundColor(Color(hex: "#072331"))
                   
                }
            }
           
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 30)
            
            
            OutlineTextfieldView(str: $password, isActive: $isActiveTextField1, label: "Mật khẩu mới", modifier: 10)
                .onTapGesture {
                    if isFirstClickPassword {
                        isActiveTextField1 = true
                        password = ""
                        isFirstClickPassword = false
                    }
                }
                .padding(.bottom, 25)
            
            OutlineTextfieldView(str: $confirmPassword, isActive: $isActiveTextField2, label: "Nhập lại mật khẩu", modifier: 9.5)
                .onTapGesture {
                    if isFirstClickConfirmPassword{
                        isActiveTextField2 = true
                        confirmPassword = ""
                        isFirstClickConfirmPassword = false
                    }
                }
                .padding(.bottom, 20)
            
            Button {
                if password == confirmPassword {
                    withAnimation{
                        showDialog = true
                    }
                }
            } label: {
                Text("Tạo mật khẩu mới")
                    .font(.custom("Work sans", size: 17))
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .accentColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            
        }
        .padding(.horizontal, 20)
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationBarBackButtonHidden(true)
        .customDialog(isShowing: $showDialog) {
            VStack(spacing: 0){
                ZStack{
                    Text("Tạo mật khẩu mới thành công")
                        .font(.custom("Work sans", size: 17))
                        .fontWeight(.bold)
                       
                    
                    HStack{
                        Spacer()
                        Button {
                            withAnimation {
                                showDialog = false
                            }
                        } label: {
                            Image(systemName: "x.circle")
                        }
                        .frame(maxWidth: 32, maxHeight: 32)
                        .foregroundColor(.gray)
                    }
                }
                .padding(.bottom, 5)
                
                Text("Giờ đây bạn có thể đăng nhập với mật khẩu mới")
                    .font(.custom("Work sans", size: 15))
                    .opacity(0.5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 10)
                
                
                Button {
                    withAnimation {
                        showDialog = false
                        isChangeLoginView = true
                    }
                    
                } label: {
                    Text("Đăng nhập")
                        .font(.custom("Work sans", size: 17))
                        .bold()
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .accentColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 10)
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                }
                
            }
            .padding(11)
            
        }
    }
    
}


struct CustomDialog<DialogContent: View>: ViewModifier {
    @Binding var isShowing: Bool // set this to show/hide the dialog
    let dialogContent: DialogContent
    
    init(isShowing: Binding<Bool>,
         @ViewBuilder dialogContent: () -> DialogContent) {
        _isShowing = isShowing
        self.dialogContent = dialogContent()
    }
    
    func body(content: Content) -> some View {
        // wrap the view being modified in a ZStack and render dialog on top of it
        ZStack {
            content
            if isShowing {
                // the semi-transparent overlay
                Rectangle().foregroundColor(Color.black.opacity(0.6))
                // the dialog content is in a ZStack to pad it from the edges
                // of the screen
                ZStack {
                    dialogContent
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.white))
                }.padding(20)
            }
        }
    }
}

extension View {
    func customDialog<DialogContent: View>(
        isShowing: Binding<Bool>,
        @ViewBuilder dialogContent: @escaping () -> DialogContent
    ) -> some View {
        self.modifier(CustomDialog(isShowing: isShowing, dialogContent: dialogContent))
    }
}

struct CreateNewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewPasswordView()
    }
}
