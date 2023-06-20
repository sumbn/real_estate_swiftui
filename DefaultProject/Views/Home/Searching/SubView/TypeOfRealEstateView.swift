//
//  CheckBoxView.swift
//  DefaultProject
//
//  Created by daktech on 6/20/23.
//

import SwiftUI

struct CheckTask: Identifiable {
    var id = UUID()
    let name: String
    var isSelected: Bool
}

struct TypeOfRealEstateView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var tasks : [CheckTask]
    
    @State private var isSelectAll: Bool = false
    
    @State private var search = ""
    
    let getSelectedList: ([String]) -> Void
    
    
    init(listName: [String], listSelected : [String] = [], getSelectedList: @escaping ([String]) -> Void){
        var tasks: [CheckTask] = []
        for name in listName {
            let isSelected = listSelected.contains(name)
            let task = CheckTask(name: name, isSelected: isSelected)
            tasks.append(task)
        }
        _tasks = State(initialValue: tasks)
        
        self.getSelectedList = getSelectedList
    }
    
    var body: some View {
        
        VStack {
            
            VStack(spacing: 9){
                HStack{
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack{
                            Image(systemName: "chevron.backward")
                            Text("Loại hình")
                                .font(.custom("Work Sans", size: 17))
                                .bold()
                        }
                        .foregroundColor(Color(hex: "#072331"))
                        
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                
                Divider()
                
                HStack {
                    Image("SearchHome")
                    TextField("Tìm giấy tờ pháp lý", text: $search)
                        .font(.custom("Work Sans Bold", size: 15))
                }
                .padding(.horizontal, 20)
            
                Divider()
                
                HStack {
                    Image(isSelectAll ? "CheckBoxSearch" : "UncheckBoxSearch")
                        .onTapGesture {
                            isSelectAll.toggle()
                            tasks.indices.forEach{
                                tasks[$0].isSelected = isSelectAll
                            }
                        }
                    Text("Tất cả")
                        .font(.custom("Work Sans", size: 15))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                
                Divider()
                
                ForEach($tasks) { $task in
                    HStack {
                        Image(task.isSelected ? "CheckBoxSearch" : "UncheckBoxSearch")
                            .onTapGesture {
                                task.isSelected.toggle()
                            }
                        Text(task.name)
                            .font(.custom("Work Sans", size: 15))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    
                    Divider()
                    
                }
            }
            .background(.white)
            
            Button {
                getSelectedList(tasks.filter{$0.isSelected}.map{
                    $0.name
                })
                presentationMode.wrappedValue.dismiss()
                
            } label: {
                Text("Áp dụng (\(tasks.filter{ $0.isSelected }.count))")
                    .font(.custom("Work Sans", size: 17))
                    .bold()
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.white)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("Text3"))
                    }
            }
            .padding(.horizontal, 20)
            
        }
        .navigationBarBackButtonHidden(true)
        .background{
            Color("Background8")
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct TypeOfRealEstateView_Previews: PreviewProvider {
    static var previews: some View {
        TypeOfRealEstateView(listName: ["Biệt thự, liền kề", "Khu đô thị mới", "Khu nghỉ dưỡng", "Khu dân cư"], listSelected: ["Khu dân cư"]){ list in
            
        }
    }
}
