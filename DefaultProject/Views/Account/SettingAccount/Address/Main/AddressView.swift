//
//  AddressView.swift
//  DefaultProject
//
//  Created by daktech on 6/9/23.
//

import SwiftUI

struct AddressView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var province_city: String = ""
    @State var tintProvince_city: String = "Chọn Tỉnh, thành phố"
    
    @State var district: String = ""
    @State var tintDistrict: String = "Chọn Quận, huyện"
    
    @State var ward: String = ""
    @State var tintWard: String = "Chọn Phường, xã, thị trấn"
    
    @State var specificAddress = ""
    @State var tintSpecificAddress = "Nhập địa chỉ cụ thể của bạn"
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.backward")
                        Text("Địa chỉ")
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
                    OutlineWithOptionView(label: "Tỉnh/ thành phố", input: $province_city, tint: $tintProvince_city, isRequired: true) {
                        
                        NavigationLink {
                            ChosingProvince()
                        } label: {
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.black)
                        }
                        .padding(.trailing,20)
                    }
                    
                    OutlineWithOptionView(label: "Quận/ huyện", input: $district, tint: $tintDistrict, isRequired: true) {
                        
                        NavigationLink {
                            ChosingDistrictView()
                        } label: {
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.black)
                        }
                        .padding(.trailing,20)
                    }
                    
                    OutlineWithOptionView(label: "Phường/ xã/ thị trấn", input: $ward, tint: $tintWard, isRequired: true) {
                        
                        NavigationLink {
                            ChosingProvince()
                        } label: {
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.black)
                        }
                        .padding(.trailing,20)
                    }
                    
                    OutlineTextFieldView(label: "Địa chỉ cụ thể", input: $specificAddress, tint: $tintSpecificAddress)
                    
                    Button {
                        
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
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color(hex: "EFEDED"))
        .navigationBarBackButtonHidden(true)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView()
    }
}
