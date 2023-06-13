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
    
    var body: some View {
        
        NavigationView {
            
      
            VStack{
                Text("tên đăng nhập: \(shareModel.userSession?.user?.displayName ?? "")")
                Text("uid: \(shareModel.userSession?.user?.uid ?? "")")
                Text("số điện thoại: \(shareModel.userSession?.user?.phoneNumber ?? "")")
                
                Button {
                    Task {
                        do {
                            try Auth.auth().signOut()
                            shareModel.userSession = nil
                            shareModel.isNotAuth = true
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
            .environmentObject(ShareModel(fireStore: FirestoreService()))
    }
}
