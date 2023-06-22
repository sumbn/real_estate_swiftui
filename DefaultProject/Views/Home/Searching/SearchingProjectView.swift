//
//  SearchingProjectView.swift
//  DefaultProject
//
//  Created by daktech on 6/19/23.
//

import SwiftUI

struct SearchingProjectView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel : SearchingProjectViewModel
    
    @State var listSelected = [String]()
    
    @State var search = ""
    @State var address = ""
    
    @State var province : String?
    @State var district : String?
    @State var commnune : String?
    
    @State private var minPrice: Int?
    @State private var maxPrice: Int?
    let priceRanges = [
        (minPrice: 0, maxPrice: 500_000_000),
        (minPrice: 500_000_000, maxPrice: 800_000_000),
        (minPrice: 800_000_000, maxPrice: 1_000_000_000),
        (minPrice: 1_000_000_000, maxPrice: 2_000_000_000),
        (minPrice: 2_000_000_000, maxPrice: 3_000_000_000),
        (minPrice: 3_000_000_000, maxPrice: 5_000_000_000),
        (minPrice: 5_000_000_000, maxPrice: 10_000_000_000),
    ]
    
    @State var decending: Bool?
    
    init(){
        let container = DependencyContainer()
        viewModel = SearchingProjectViewModel(firestore: container.firestoreService)
    }
    
    var body: some View {
        VStack{

            HStack(spacing: 0){
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.backward")
                    }
                    .foregroundColor(Color(hex: "#072331"))
                }
                .padding(.trailing, 12)
                
                HStack(spacing: 0){
                    Button {
                        
                    } label: {
                        Image("SearchHome")
                    }
                    .padding(.horizontal, 10)
                    
                    TextField("Tìm kiếm nhà, đất, khu vực", text: $search)
                        .font(.custom("Work Sans Bold", size: 15))
                }
                .frame(maxWidth: .infinity, maxHeight: 45)
                .background {
                    RoundedRectangle(cornerRadius: 9)
                        .fill(Color("Background6"))
                }
                
                Image("NotifyHome")
                    .padding(.leading, 18)
                    .padding(.trailing, 4)
                
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 10)
            
            HStack{
                
                Image("SearchingLocationIcon")
                
                Text("Khu vực:")
                    .font(.custom("Work Sans", size: 15))
                    .foregroundColor(Color("Text6"))
                
                Text(address)
                    .padding(.vertical, 12)
                    .padding(.leading, 12)
                    .padding(.trailing, 6)
                    .frame(maxWidth: 235, alignment: .leading)
                
                Menu {
                    ForEach(viewModel.listProvince, id: \.id) { province in
                        Menu {
                            ForEach(province.districts, id: \.id){ district in
                                Menu {
                                    ForEach(district.communes, id: \.id){ commune in
                                        Button {
                                            address = province.name + district.name + commune.name
                                            self.province = province.name
                                            self.district = district.name
                                            self.commnune = commune.name
                                        } label: {
                                            //                                            Text(commune.name)
                                            HStack {
                                                Text(commune.name)
                                                if self.province == province.name && self.district == district.name && self.commnune == commune.name {
                                                    Spacer()
                                                    Image(systemName: "checkmark")
                                                        .foregroundColor(.blue)
                                                }
                                            }
                                        }
                                    }
                                } label: {
                                    HStack {
                                        Text(district.name)
                                        if self.province == province.name && self.district == district.name {
                                            Spacer()
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.blue)
                                        }
                                    }
                                }
                            }
                        } label: {
                            
                            HStack {
                                Text(province.name)
                                if self.province == province.name{
                                    Spacer()
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                            
                        }
                    }
                } label: {
                    Image("TriangleDownHome")
                }
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView (.horizontal){
                
                LazyHStack {
                    Button {
                        filterData()
                    } label: {
                        HStack(spacing: 4) {
                            Image("SearchingFilterIcon")
                            Text("Lọc")
                                .foregroundColor(Color.black)
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 9)
                        .background {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color("Text6").opacity(0.7))
                        }
                    }
                    
                    NavigationLink {
                        TypeOfRealEstateView(listName: ["Biệt thự, liền kề","Khu đô thị mới","Khu nghỉ dưỡng", "Khu dân cư", "Cao ốc văn phòng", "Trung tâm thương mại"], listSelected: listSelected) { [self] list in
                            listSelected = list
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Text("Biệt thự, liền kề")
                                .foregroundColor(Color.black)
                            Image("TriangleDownHome")
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 9)
                        .background {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color("Text6").opacity(0.7))
                        }
                    }
                    
                    Menu {
                        ForEach(0..<priceRanges.count) { index in
                            Button {
                                minPrice = priceRanges[index].minPrice
                                maxPrice = priceRanges[index].maxPrice
                            } label: {
                                HStack {
                                    Text("\(readNumber(priceRanges[index].minPrice))-\(readNumber(priceRanges[index].maxPrice))")
                                    
                                    if self.minPrice == priceRanges[index].minPrice{
                                        Spacer()
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.blue)
                                    }
                                }
                                
                            }
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Text("Giá mua bán")
                                .foregroundColor(Color.black)
                            Image("TriangleDownHome")
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 9)
                        .background {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color("Text6").opacity(0.7))
                        }
                    }
                    
                    Button {
                        decending = true
                    } label: {
                        HStack(spacing: 4) {
                            Text("Giá +")
                                .foregroundColor(Color.black)
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 9)
                        .background {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color("Background8"))
                            
                        }
                    }
                    
                    Button {
                        decending = false
                    } label: {
                        HStack(spacing: 4) {
                            Text("Giá -")
                                .foregroundColor(Color.black)
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 9)
                        .background {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color("Background8"))
                            
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack(spacing: 4) {
                            Text("Dự án ")
                                .foregroundColor(Color.black)
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 9)
                        .background {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color("Background8"))
                        }
                    }
                }
            }
            .frame(height: 35, alignment: .leading)
            .padding(.leading, 20)
            .padding(.bottom, 16)
            
            Rectangle()
                .frame(height: 16)
                .foregroundColor(Color("Background7"))
            
            
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack{
                    ForEach(viewModel.listSearchedItem, id: \.id) { post in
                        ItemSearchingProjectView(post: post)
                    }
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    func filterData(){
        
        var filters : [FilterCondition] = []
        
        if listSelected.count > 0 {
            filters.append(FilterCondition(field: "category", filterOperator: .inQuery, value: listSelected))
        }
        
        if let minPrice {
            if minPrice != 0 {
                filters.append(FilterCondition(field: "price", filterOperator: .isGreaterThanOrEqualTo, value: minPrice))
            }
        }
        
        if let maxPrice {
            filters.append(FilterCondition(field: "price", filterOperator: .isLessThanThanOrEqualTo, value: maxPrice))
        }
        
        if let province {
            filters.append(FilterCondition(field: "province_city", filterOperator: .isEqualTo, value: province))
        }
        
        if let district {
            filters.append(FilterCondition(field: "district", filterOperator: .isEqualTo, value: district))
        }
        
        if let commnune {
            filters.append(FilterCondition(field: "commune", filterOperator: .isEqualTo, value: commnune))
        }
        
        viewModel.filterData(filter: filters, orderBy: "price", decending: decending, limit: nil)
    }
}

struct SearchingProjectView_Previews: PreviewProvider {
    static var previews: some View {
        SearchingProjectView()
    }
}


// Helper function to format the price
func formatPrice(_ price: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = ","
    return formatter.string(from: NSNumber(value: price)) ?? "\(price)"
}
