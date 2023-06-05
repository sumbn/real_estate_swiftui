//
//  ContentView.swift
//  DefaultProject
//
//  Created by CycTrung on 04/06/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Rectangle()
                .frame(width: 300, height: 50, alignment: .center)
            Rectangle()
                .frame(width: 300, height: 20, alignment: .center)
        }
        .padding()
        .shimmering()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
