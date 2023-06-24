//
//  FakeDropDownView.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/31/23.
//

import SwiftUI

struct FakeDropDownView: View {
    
    @Binding var selection: String
    
    @Binding var tint : String
    
    var label: String = "Loại hình căn hộ"
    var listOptions : [String]
    
    var labelAtribute: AttributedString
    var request: AttributedString
    
    init(selection: Binding<String>, tint: Binding<String> = .constant(""),listOptions : [String] = ["abc", "def"] ,label: String, isRequested: Bool = false) {
        self._selection = selection
        self.listOptions = listOptions
        self.label = label
        self.labelAtribute = {
            var result = AttributedString(label)
            result.font = UIFont(name: workSansFont, size: 13)
            result.foregroundColor = .black
            return result
        }()
        if isRequested{
            self.request = {
                var result = AttributedString("*")
                result.font = UIFont(name: workSansFont, size: 13)
                result.foregroundColor = Color(hex: "#DF4B4B")
                return result
            }()
        } else {
            self.request = AttributedString("")
        }
        self._tint = tint
    }
    
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 1)
                .opacity(0.08)
                .frame(maxWidth: .infinity, maxHeight: 56)
                .background {
                    Color.clear
                }
            
            if selection == "" {
                Text(tint)
                    .opacity(0.5)
                    .font(.custom(workSansFont, size: 17))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
            }
            
            HStack{
                Text(selection)
                    .font(.custom(workSansFont, size: 17))
                    .lineLimit(1)
                
                Spacer()
                
                Menu {
                    ForEach(listOptions, id: \.self) { string in
                        Button(string) {
                            selection = string
                        }
                    }
                } label: {
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color(hex: "#070707"))
                }
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
        }
        .overlay(alignment: .topLeading) {
            Text(labelAtribute + request)
                .font(.custom(workSansFont, size: 13))
                .padding(.horizontal, 5)
                .padding(.vertical, 5)
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                }
                .offset(x : 20 ,y: -14)
        }
        .frame(height: 56)
        
    }
}

struct FakeDropDownView_Previews: PreviewProvider {
    static var previews: some View {
        FakeDropDownView(selection: .constant("test"), label: "test",isRequested: true)
    }
}
