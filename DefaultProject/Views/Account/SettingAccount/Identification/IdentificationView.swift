//
//  IdentificationView.swift
//  DefaultProject
//
//  Created by daktech on 6/9/23.
//

import SwiftUI

struct IdentificationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var id : String
    @State var tintId : String = "CMND/CCCD/Hộ chiếu của bạn"
    
    @State var dateOfIssued : String
    @State var tintDateOfIssued : String = "Nhập ngày cấp"
    
    @State var issuedBy : String
    @State var tintIssuedBy : String = "Địa chỉ nơi cấp"
    
    let getIdentify: (IDModel) -> Void
    
    init(idModel: IDModel, getIdentify: @escaping (IDModel) -> Void) {
        self.getIdentify = getIdentify
        _id = State(initialValue: idModel.no ?? "")
        _dateOfIssued = State(initialValue: idModel.dateOfIssued ?? "")
        _issuedBy = State(initialValue: idModel.issuedBy ?? "")
        
    }
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.backward")
                        Text("CCCD/CMND/Hộ chiếu")
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
            
            VStack(spacing: 16){
                OutlineTextFieldView(label: "Số CCCD/CMND/Hộ chiếu", input: $id, tint: $tintId)
                
                OutlineTextFieldView(label: "Ngày cấp", input: $dateOfIssued, tint: $tintDateOfIssued)
                
                OutlineTextFieldView(label: "Nơi cấp", input: $issuedBy, tint: $tintIssuedBy)
                
                Button {
                    let idModel = IDModel(no: id, dateOfIssued: dateOfIssued, issuedBy: issuedBy)
                    getIdentify(idModel)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Xong")
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
            .padding(.top, 16)
            .padding(.horizontal, 20)
            .background {
                Color.white
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color(hex: "EFEDED"))
        .navigationBarBackButtonHidden(true)
    }
}

struct IdentificationView_Previews: PreviewProvider {
    static var previews: some View {
        IdentificationView(idModel: IDModel(no: "", dateOfIssued: "", issuedBy: "")){ identify in
            
        }
    }
}
