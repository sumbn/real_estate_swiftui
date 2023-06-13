//
//  AccountView.swift
//  DefaultProject
//
//  Created by daktech on 6/8/23.
//

import SwiftUI

struct AccountView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var shareModel : ShareModel
    
    @State var toggle = false
    
    var body: some View {
        NavigationView {
            
            
            VStack(spacing: 0){
                Text("Tài khoản")
                    .font(.custom("Work Sans", size: 32))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack{
                    
                    Image("chooseImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 74, height: 74)
                        .clipShape(Circle())
                        .overlay(alignment: .bottomTrailing) {
                            
                            NavigationLink {
                                EditAvatarView()
                            } label: {
                                Image("Edit")
                            }
                        }
                    
                    Text(shareModel.userSession?.user?.displayName ?? "Test")
                        .font(.custom("Work Sans", size: 20))
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 30)
                
                VStack(spacing: 15){
                    HStack{
                        Image("Notify")
                            .padding(12)
                        
                        Text("Bật/ Tắt thông báo")
                            .font(.custom("Work Sans", size: 15))
                        
                        Toggle(isOn: $toggle) {
                            
                        }
                        .padding(.horizontal, 16)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 56, alignment: .leading)
                    .background {
                        RoundedRectangle(cornerRadius: 36)
                            .fill(Color("Background5")
                                .opacity(0.25))
                    }
                    
                    HStack{
                        Image("HeartCircle")
                            .padding(12)
                        
                        Text("Tin đã lưu")
                            .font(.custom("Work Sans", size: 15))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.forward")
                            .foregroundColor(Color("Icon2"))
                            .padding(.horizontal, 22)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 56, alignment: .leading)
                    .background {
                        RoundedRectangle(cornerRadius: 36)
                            .fill(Color("Background5")
                                .opacity(0.25))
                    }
                    
                    NavigationLink {
                        EditInfomationView()
                    } label: {
                        HStack{
                            Image("SettingAccount")
                                .padding(12)
                            
                            Text("Cài đặt tài khoản")
                                .font(.custom("Work Sans", size: 15))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.forward")
                                .foregroundColor(Color("Icon2"))
                                .padding(.horizontal, 22)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 56, alignment: .leading)
                        .background {
                            RoundedRectangle(cornerRadius: 36)
                                .fill(Color("Background5")
                                    .opacity(0.25))
                        }
                    }
                    
                    HStack{
                        Image("Help")
                            .padding(12)
                        
                        Text("Trợ giúp")
                            .font(.custom("Work Sans", size: 15))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.forward")
                            .foregroundColor(Color("Icon2"))
                            .padding(.horizontal, 22)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 56, alignment: .leading)
                    .background {
                        RoundedRectangle(cornerRadius: 36)
                            .fill(Color("Background5")
                                .opacity(0.25))
                    }
                    
                    HStack{
                        Image("SignOut")
                            .padding(12)
                        
                        Text("Đăng xuất")
                            .font(.custom("Work Sans", size: 15))
                        
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: 56, alignment: .leading)
                    .background {
                        RoundedRectangle(cornerRadius: 36)
                            .fill(Color("Background5")
                                .opacity(0.25))
                    }
                    
                }
                .padding(.horizontal, 10)
                
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .environmentObject(ShareModel(fireStore: FirestoreService()))
    }
}
