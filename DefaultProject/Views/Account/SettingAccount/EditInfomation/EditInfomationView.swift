//
//  EditInfomationView.swift
//  DefaultProject
//
//  Created by daktech on 6/9/23.
//

import SwiftUI

struct EditInfomationView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var shareModel : ShareModel
    
    let viewModel : EditInfomationViewModel
    
    @State var name: String = ""
    @State var tintName: String = "Tên của bạn"
    
    @State var address: String = ""
    @State var tintAddress: String = "Địa chỉ của bạn"
    
    @State var phoneNumber: String = ""
    @State var tintphoneNumber: String = "Số điện thoại của bạn"
    
    @State var introduce: String = ""
    @State var tintIntroduce: String = "Viết vài dòng giới thiệu về gian hàng của bạn...( tối đa 60 từ)"
    
//    @State var identification: String = ""
    @State var id : String = ""
    @State var dayOfIssue: String = ""
    @State var issueBy: String = ""
    @State var tintIdentification: String = "CMND/CCCD/Hộ chiếu của bạn"
    
    @State var isCFDGender = false
    @State var gender: String = ""
    @State var tintGender: String = "Chọn giới tính của bạn"
    
    @State var isShowDatePicker = false
    @State var date : Date = {
        let date = "01/01/1900"
        return convertStringToDate(from: date)!
    }()
    @State var birthDay : String = ""
    @State var tintBirthDay : String = "Chọn ngày, tháng, năm sinh"
    
    
    @State var addressModel: AddressModel = AddressModel(province: "", district: "", commune: "", specific: "")
    {
        willSet(newValue){
            address = newValue.province ?? ""
        }
    }
    
    
    
    @State var isToggle = false
    
    @State var isSheet = false
    
    init(){
        let container = DependencyContainer()
        viewModel = EditInfomationViewModel(storageService: container.storageService, firestoreService: container.firestoreService)
    }
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.backward")
                        Text("Chỉnh sửa trang cá nhân")
                            .font(.custom("Work Sans", size: 17))
                            .bold()
                    }
                    .foregroundColor(Color(hex: "#072331"))
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 18)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white)
            .padding(.bottom, 16)
            
            ScrollView {
                VStack(spacing: 16){
                    
                    Text("Thông tin cá nhân")
                        .font(.custom("Work Sans", size: 17))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 8)
                    
                    OutlineTextFieldView(label: "Họ và tên", input: $name, tint: $tintName, isRequired: true)
                    
                    OutlineWithOptionView(label: "Địa chỉ", input: $address, tint: $tintAddress) {
                        
                        NavigationLink {
                            AddressView(addressModel: addressModel) { addressModel in
                                self.addressModel = addressModel
                                address = addressModel.province ?? ""
                            }
                        } label: {
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.black)
                        }
                        .padding(.trailing,20)
                        
                    }
                    
                    OutlineTextFieldView(label: "Số điện thoại", input: $phoneNumber, tint: $tintphoneNumber, isRequired: true)
                    
                    VStack(spacing: 8){
                        Text("Cho phép người mua liên lạc qua điện thoại")
                            .font(.custom("Work Sans", size: 15))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Khi bật tính năng này, số điện thoại sẽ hiển thị trên tất cả tin đăng của bạn")
                            .font(.custom("Work Sans", size: 15))
                            .opacity(0.47)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack{
                            Spacer()
                            Toggle(isOn: $isToggle) {
                                
                            }
                        }
                    }
                    .padding(.top, 8)
                    
                    OutlineTextFieldView(label: "Giới thiệu", input: $introduce, tint: $tintIntroduce, isOneLine: false)
                    
                    OutlineWithOptionView(label: "CMND/CCCD/Hộ chiếu", input: $id, tint: $tintIdentification) {
                        
                        NavigationLink {
                            IdentificationView(id: $id, dateOfIssued: $dayOfIssue, issuedBy: $issueBy)
                        } label: {
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.black)
                        }
                        .padding(.trailing,20)
                    }
                    
                    OutlineWithOptionView(label: "Giới tính", input: $gender, tint: $tintGender) {
                        
                        Button {
                            isCFDGender = true
                        } label: {
                            Image(systemName: "chevron.down")
                                .foregroundColor(.black)
                        }
                        .padding(.trailing,20)
                    }
                    
                    VStack(spacing: 5) {
                        OutlineWithOptionView(label: "Ngày, tháng, năm sinh", input: $birthDay, tint: $tintBirthDay) {
                            
                            Button {
                                isShowDatePicker.toggle()
                                isSheet = true
                            } label: {
                                Image(systemName: isShowDatePicker ? "chevron.up" : "chevron.down")
                                    .foregroundColor(.black)
                            }
                            .padding(.trailing,20)
                        }
                        
                        if isShowDatePicker {
                            VStack {
                                DatePicker(selection: $date, displayedComponents: .date) {
                                    Text("Chọn ngày sinh của bạn")
                                        .padding(.horizontal, 20)
                                }
                                .datePickerStyle(.compact)
                                
                                HStack{
                                    Spacer()
                                    Button {
                                        birthDay = convertDateToString(from: date)
                                        isShowDatePicker = false
                                    } label: {
                                        Text("Done")
                                            .font(.custom("Work Sans", size: 17))
                                            .bold()
                                            .foregroundColor(Color.white)
                                            .padding(.vertical, 10)
                                            .padding(.horizontal, 20)
                                            .background(Color("Text3"))
                                            .cornerRadius(10)
                                    }
                                }
                            }
                        }
                    }
                    
                    Button {
                        handlerEventButtonSave{
                            presentationMode.wrappedValue.dismiss()
                        }
                        
                    } label: {
                        Text("Lưu")
                            .font(.custom("Work Sans", size: 17))
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .accentColor(Color.white)
                            .background(Color("Text3"))
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 16)

                }
                .padding(.top, 8)
                .padding(.horizontal, 20)
                .background {
                    Color.white
                }
            }
        }
        .confirmationDialog("Gender selection", isPresented: $isCFDGender) {
            Button("Nam") {
                gender = "Nam"
            }
            
            Button("Nữ") {
                gender = "Nữ"
            }
            
            Button("Khác") {
                gender = "Khác"
            }
        } message: {
            Text("Chọn giới tính")
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color("Background7"))
        .navigationBarBackButtonHidden(true)
        .onAppear{
            if name == ""{
                viewModel.getData(collection: Constants.pathAccount, document: shareModel.userSession?.user?.uid ?? "") { [self] account in
                    name = account.name ?? ""
                    addressModel = account.address ?? AddressModel(province: "", district: "", commune: "", specific: "")
                    phoneNumber = account.phoneNumber ?? ""
                    introduce = account.bio ?? ""

                    id = account.identify?.no ?? ""
                    dayOfIssue = account.identify?.dateOfIssued ?? ""
                    issueBy = account.identify?.issuedBy ?? ""

                    gender = account.gender ?? ""

                    birthDay = account.dayOfBirth ?? ""
                }
                print("on appear")
            }
            
        }
    }
    
    
    func handlerEventButtonSave(completion: @escaping () -> Void){
        
        let account = AccountModel(name: name, address: addressModel, phoneNumber: phoneNumber, bio: introduce, identify: IDModel(no: id, dateOfIssued: dayOfIssue, issuedBy: issueBy), gender: gender, dayOfBirth: birthDay)
        
        viewModel.updateDataFireStore(uid: shareModel.userSession?.user?.uid ?? "", data: account, completion: completion)
    }
}

struct EditInfomationView_Previews: PreviewProvider {
   
    static var previews: some View {
        let shareModel = ShareModel()
        var modifiedShareModel = shareModel
        modifiedShareModel.userSession = AuthenticationModel(provider: .google, user: UserModel(uid: "123", displayName: "", email: "", photoURL: "", phoneNumber: "", verificationCode: "", verificationID: ""))
        
        return EditInfomationView()
            .environmentObject(modifiedShareModel)
    }
}



