//
//  OutlineWithOptionView.swift
//  DefaultProject
//
//  Created by daktech on 6/9/23.
//

import SwiftUI

struct OutlineWithOptionView <T : View>: View {
    @Binding var input : String
    
    @State var isFirstClick = true
    
    @Binding var tint : String
    
    var labelAtribute: AttributedString
    var requestAtribute: AttributedString
   
    var view: T?
    
    init(label: String, input: Binding<String>, tint: Binding<String> ,isRequired: Bool = false, @ViewBuilder content: () -> T) {
        
        self._tint = tint
        self._input = input
        
        self.labelAtribute = {
            var result = AttributedString(label)
            result.font = UIFont(name: "Work Sans", size: 13)
            result.foregroundColor = .black
            return result
        }()
        
        if isRequired {
            self.requestAtribute = {
                var result = AttributedString("*")
                result.font = UIFont(name: "Work Sans", size: 13)
                result.foregroundColor = .red
                return result
            }()
        } else {
            self.requestAtribute = {
                let result = AttributedString("")
                return result
            }()
        }
        
        self.view = content()
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
            
            if input == "" {
                Text(tint)
                    .lineLimit(1)
                    .opacity(0.5)
                    .font(.custom("Work Sans", size: 17))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
            }
            
            Text(input)
                .lineLimit(1)
                .font(.custom("Work Sans", size: 17))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
        }
        .frame(height: 56)
        .overlay(alignment: .topLeading) {
            Text(labelAtribute + requestAtribute)
                .font(.custom("Work Sans", size: 13))
                .padding(.horizontal, 5)
                .padding(.vertical, 5)
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                }
                .offset(x : 20 ,y: -14)
        }
        .overlay(alignment: .trailing) {
                    view
                }
    }
}

struct OutlineWithOptionView_Previews: PreviewProvider {
    static var previews: some View {
        OutlineWithOptionView(label: "label", input: .constant("abcd"), tint: .constant("tint"), isRequired: true){
            Text("test")
        }
    }
}
