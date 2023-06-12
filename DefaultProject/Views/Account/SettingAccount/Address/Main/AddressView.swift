//
//  AddressView.swift
//  DefaultProject
//
//  Created by daktech on 6/9/23.
//

import SwiftUI

struct AddressView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var listProvince = [Province]()
    @State var indexSelectedProvince : Int?
    @State var province_city: String{
        didSet {
            district = ""
            indexSelectedDistrict = nil
        }
    }
    @State var tintProvince_city: String = "Chọn Tỉnh, thành phố"
    
    @State var indexSelectedDistrict: Int?
    @State var district: String{
        didSet {
            commune = ""
            indexSelectedCommune = nil
        }
    }
    @State var tintDistrict: String = "Chọn Quận, huyện"
    
    @State var indexSelectedCommune: Int?
    @State var commune: String
    @State var tintCommune: String = "Chọn Phường, xã, thị trấn"
    
    @State var specificAddress: String
    @State var tintSpecificAddress = "Nhập địa chỉ cụ thể của bạn"
    
    let getAddressModel: (AddressModel) -> Void
   
    
    init(addressModel: AddressModel, getAddress: @escaping (AddressModel) -> Void){
        
        getAddressModel = getAddress
        _province_city = State(initialValue: addressModel.province)
        _district = State(initialValue: addressModel.district)
        _commune = State(initialValue: addressModel.commune)
        _specificAddress = State(initialValue: addressModel.specific)
    }
    
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
                            ChosingProvince(listProvince: listProvince, selectedItem: indexSelectedProvince){ index in
                                indexSelectedProvince = index
                                province_city = listProvince[indexSelectedProvince!].name
                            }
                        } label: {
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.black)
                        }
                        .padding(.trailing,20)
                    }
                    
                    OutlineWithOptionView(label: "Quận/ huyện", input: $district, tint: $tintDistrict, isRequired: true) {
                        NavigationLink {
                            if(indexSelectedProvince != nil) {
                                ChosingDistrictView(listDistrict: listProvince[indexSelectedProvince!].districts, selectedItem: indexSelectedDistrict){ index in
                                    indexSelectedDistrict = index
                                    district = listProvince[indexSelectedProvince!].districts[indexSelectedDistrict!].name
                                }
                            }
                        } label: {
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.black)
                        }
                        .padding(.trailing,20)
                    }
                    .disabled(province_city == "")
                    
                    OutlineWithOptionView(label: "Phường/ xã/ thị trấn", input: $commune, tint: $tintCommune, isRequired: true) {
                        
                        NavigationLink {
                            if(indexSelectedDistrict != nil) {
                                ChosingCommuneView(listCommune: listProvince[indexSelectedProvince!].districts[indexSelectedDistrict!].communes, selectedItem: indexSelectedCommune){ index in
                                    indexSelectedDistrict = index
                                    commune = listProvince[indexSelectedProvince!].districts[indexSelectedDistrict!].communes[indexSelectedProvince!].name
                                }
                            }
                        } label: {
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.black)
                        }
                        .padding(.trailing,20)
                        
                    }
                    .disabled(district == "")
                    
                    OutlineTextFieldView(label: "Địa chỉ cụ thể", input: $specificAddress, tint: $tintSpecificAddress)
                    
                    Button {
                        let address = AddressModel(province: province_city, district: district, commune: commune, specific: specificAddress)
                        getAddressModel(address)
                        
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
        }
        .onAppear{
            listProvince = Bundle.main.decode(type: [Province].self, from: "fakeJson.json")
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color(hex: "EFEDED"))
        .navigationBarBackButtonHidden(true)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(addressModel: AddressModel(province: "", district: "", commune: "", specific: "")){ address in
            
        }
    }
}
