//
//  MainView.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/11/23.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
    @EnvironmentObject var shareModel: ShareModel
    
    @State var realEstateCategory = "Mua bán"
    
    var body: some View {
        
        NavigationView {
            VStack {
                HStack{
                    
                    HStack{
                        Text(realEstateCategory)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 45)
                    .background {
                        RoundedRectangle(cornerRadius: 9)
                            .fill(Color("Background6"))
                    }
                    
                    Image("NotifyHome")
                        .padding(16)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ShareModel())
    }
}
