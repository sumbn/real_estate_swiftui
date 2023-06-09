//
//  PhoneVerificationView.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/12/23.
//

import SwiftUI

struct PhoneVerificationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel : PhoneVerificationViewModel
    @EnvironmentObject var shareModel: ShareModel
    
    @ObservedObject var viewModelForResentOTP: ForgetPasswordViewModel
    
    @FocusState var activeField : OTPField?
    
    init(){
        let confirmOtpService = AuthService(signInService: ConfirmOTPService())
        self.viewModel = PhoneVerificationViewModel(authService: confirmOtpService)
        let sentOTPService = AuthService(signInService: SendSmsOTPService())
        self.viewModelForResentOTP = ForgetPasswordViewModel(authService: sentOTPService)
    }
    
    var body: some View {
        VStack(spacing: 0){
            
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.backward")
                        Text("Lấy lại mật khẩu")
                            .font(.custom("Work Sans Bold", size: 17))
                    }
                    .foregroundColor(Color(hex: "#072331"))
                }
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Lấy lại mật khẩu")
                .font(.custom("Work Sans Bold", size: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 40)
            
            Text("Nhập mã OTP mà chúng tôi đã gửi vào số di động \(shareModel.userSession?.user?.phoneNumber ?? "")")
                .font(.custom("Work Sans", size: 15))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 16)
            
            OTPField()
                .padding(.top, 20)
                .padding(.horizontal, 20)
                .padding(.bottom, 26)
            
            if(checkStates()){
                Button {
                    viewModel.comFirmOTP(authentication: shareModel.userSession!) { result in
                        shareModel.userSession = result
                        shareModel.isNotAuth = false
                    }
                } label: {
                    Text("Xác thực")
                        .foregroundColor(Color(hex: "#5276F0"))
                        .font(.custom("Work Sans", size: 15))
                }
            } else {
                Button {
                    viewModelForResentOTP.sendOtpToPhoneNumber(phoneNumber: (shareModel.userSession?.user?.phoneNumber)!) { result in
                        shareModel.userSession = result
                        
                    }
                } label: {
                    Text("Gởi lại OTP")
                        .foregroundColor(Color(hex: "#5276F0"))
                        .font(.custom("Work Sans", size: 15))
                        .underline()
                }
            }
        }
        .onChange(of: viewModel.otpFields, perform: { newValue in
            OTPCondition(value: newValue)
        })
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationBarBackButtonHidden(true)
    }
    
    func checkStates()-> Bool{
        for index in 0..<6{
            if viewModel.otpFields[index].isEmpty{return false }
        }
        
        return true
    }
    
    func OTPCondition(value: [String]){
        
        for index in 0..<5{
            if value[index].count == 1 && activeStateForIndex(index: index) == activeField{
                activeField = activeStateForIndex(index: index + 1)
            }
        }
        
        for index in 1...5{
            if value[index].isEmpty && !value[index-1].isEmpty{
                activeField = activeStateForIndex(index: index - 1)
            }
        }
        
        
        for index in 0..<6{
            if value[index].count>1 {
                viewModel.otpFields[index] = String(value[index].last!)
            }
        }
    }
    
    @ViewBuilder
    func OTPField()-> some View {
        HStack(spacing: 8) {
            ForEach(0..<6, id: \.self){ index in
                ZStack {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .stroke(activeField == activeStateForIndex(index: index) ? Color.blue : Color(.black).opacity(0.1), lineWidth: 1)
                        .background{
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color("Background4"))
                        }
                    
                    TextField("-", text: $viewModel.otpFields[index])
                        .foregroundColor(.black).opacity(0.4)
                        .font(.system(size: 15))
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .multilineTextAlignment(.center)
                        .focused($activeField, equals: activeStateForIndex(index: index))
                }
                .frame(width: 50, height: 50)
            }
            
        }
    }
    
    func activeStateForIndex(index: Int) -> OTPField {
        switch index{
        case 0: return.field1
        case 1: return.field2
        case 2: return.field3
        case 3: return.field4
        case 4: return.field5
        default:
            return.field6
        }
    }
    
}

enum OTPField{
    case field1
    case field2
    case field3
    case field4
    case field5
    case field6
}

struct PhoneVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneVerificationView()
            .environmentObject(ShareModel())
    }
}
