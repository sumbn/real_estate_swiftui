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
    @State var selectedProvince : Province? {
        didSet{
            if(selectedProvince != nil){
                for disstric in selectedProvince!.districts {
                    if (district == disstric.name){
                        selectedDistrict = disstric
                    }
                }
            }
        }
    }
    
    @Binding var province_city: String{
        willSet(newValue){
            if(newValue != province_city){
                district = ""
                selectedDistrict = nil
            }
        }
    }
    
    @State var tintProvince_city: String = "Chọn Tỉnh, thành phố"
    
    @State var selectedDistrict: District?
    @Binding var district: String
    {
        willSet(newValue){
            if(newValue != district){
                commune = ""
            }
        }
    }
    
    @State var tintDistrict: String = "Chọn Quận, huyện"
    
    @Binding var commune: String
    {
        willSet(newValue){
            if(newValue != commune){
                specificAddress = ""
            }
        }
    }
    
    @State var tintCommune: String = "Chọn Phường, xã, thị trấn"
    
    @Binding var specificAddress: String
    @State var tintSpecificAddress = "Nhập địa chỉ cụ thể của bạn"
    
    let onCompletion: (String, String, String) -> Void
    
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.backward")
                        Text("Địa chỉ")
                            .font(.custom(workSansFont, size: 17))
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
                            ChosingProvince(listProvince: listProvince, selectedItem: province_city){ province in
                                selectedProvince = province
                                province_city = province.name
                            }
                        } label: {
                            Image(systemName: "chevron.forward")
                                .foregroundColor(.black)
                        }
                        .padding(.trailing,20)
                    }
                    
                    OutlineWithOptionView(label: "Quận/ huyện", input: $district, tint: $tintDistrict, isRequired: true) {
                        NavigationLink {
                            if(selectedProvince != nil) {
                                ChosingDistrictView(listDistrict: selectedProvince!.districts, selectedItem: district){ result in
                                    selectedDistrict = result
                                    district = result.name
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
                            if(selectedDistrict != nil) {
                                ChosingCommuneView(listCommune: selectedDistrict!.communes, selectedItem: commune){ communeResult in
                                    commune = communeResult.name
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
//                        let address = AddressModel(province: province_city, district: district, commune: commune, specific: specificAddress)
//                        getAddressModel(address)
                        onCompletion(province_city, district,commune)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Xong")
                            .font(.custom(workSansFont, size: 17))
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
            for province in listProvince {
                if (province.name == province_city){
                    selectedProvince = province
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color("Background7"))
        .navigationBarBackButtonHidden(true)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
//        AddressView(addressModel: AddressModel(province: "", district: "", commune: "", specific: "")){ address in
//
//        }
        AddressView(province_city: .constant("abc"), district: .constant("ikl"), commune: .constant("vch"), specificAddress: .constant("iop")){ a,b,c in
            
        }
    }
}
