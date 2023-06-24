//
//  ConfirmPhoneNumber.swift
//  AuthenWithFirebases
//
//  Created by daktech on 5/22/23.
//

import Foundation
import SwiftUI

struct ConfirmPhoneNumberView : View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel : ConfirmPhoneNumberViewModel
    @EnvironmentObject var coordinator: ShareModel
    
    @ObservedObject var vỉewModelForResentOTP: SignUpViewModel
    
    @FocusState var activeField : OTPField?
    
    @State var isChangeScreen: Bool = false
    
    init(){
        let confirmOtpService = AuthService(signInService: ConfirmOTPService())
        self.viewModel = ConfirmPhoneNumberViewModel(authService: confirmOtpService)
        
        let resentOTPService = AuthService(signInService: SendSmsOTPService())
        self.vỉewModelForResentOTP = SignUpViewModel(authService: resentOTPService)
    }
    
    var body: some View {
        VStack{
            NavigationLink(destination: SignUpSuccessView(), isActive: $isChangeScreen) {
            }
            
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.backward")
                        Text("Xác thực số điện thoại")
                            .font(.custom(workSansFont, size: 17))
                            .bold()
                    }
                    .foregroundColor(Color("Background3"))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 40)
            
            
            Text("Xác thực số điện thoại")
                .font(.custom(workSansFont, size: 24))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 16)
            
            Text("Nhập mã OTP mà chúng tôi đã gửi vào số di động: \(coordinator.userSession?.user?.phoneNumber ?? "")")
                .font(.custom(workSansFont, size: 15))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            OTPField()
                .padding(.vertical, 26)
            
            if(checkStates()){
                Button {
                    viewModel.comFirmOTP(authentication: coordinator.userSession!) { result in
                        coordinator.userSession = result
                        isChangeScreen = true
                    }
                } label: {
                    Text("Xác thực")
                        .foregroundColor(Color("Text3"))
                        .font(.custom(workSansFont, size: 15))
                }
            } else {
                Button {
                    vỉewModelForResentOTP.sendOtpToPhoneNumber(phoneNumber: (coordinator.userSession?.user?.phoneNumber)!) { result in
                        coordinator.userSession = result
                    }
                } label: {
                    Text("Gởi lại OTP")
                        .foregroundColor(Color("Text3"))
                        .font(.custom(workSansFont, size: 15))
                        .underline()
                }
            }
        }
        .padding(.horizontal, 20)
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
                        .stroke(activeField == activeStateForIndex(index: index) ? .blue : .gray, lineWidth: 0.5)
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


//struct ConfirmPhoneNumberView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConfirmPhoneNumberView()
//    }
//}
