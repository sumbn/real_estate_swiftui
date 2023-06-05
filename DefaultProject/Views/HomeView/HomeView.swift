//
//  MainView.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/11/23.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
    @EnvironmentObject var coordinator: ShareModel
    
    var body: some View {
        NavigationView{
            VStack{
                Text("tên đăng nhập: \(coordinator.userSession?.user?.displayName ?? "")")
                Text("uid: \(coordinator.userSession?.user?.uid ?? "")")
                Text("số điện thoại: \(coordinator.userSession?.user?.phoneNumber ?? "")")
                
                Button {
                    Task {
                        do {
                            try Auth.auth().signOut()
                            coordinator.isNotAuth = true
                        } catch {
                            print("Error signing out: \(error)")
                        }
                    }
                } label: {
                    Text("Sign Out")
                }
                
                NavigationLink {
                    PostingScreenView()
                } label: {
                
                    Text("Chuyển sang màn posting")
                        .font(.custom("Work Sans", size: 17))
                        .bold()
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                        }
                        .padding(20)
                    
                }
                
                NavigationLink {
                    GetAllPostView()
                } label: {
                
                    Text("Chuyển sang màn get all post")
                        .font(.custom("Work Sans", size: 17))
                        .bold()
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                        }
                        .padding(20)
                    
                }
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
