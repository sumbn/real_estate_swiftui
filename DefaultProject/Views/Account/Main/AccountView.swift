//
//  AccountView.swift
//  DefaultProject
//
//  Created by daktech on 6/8/23.
//

import SwiftUI
import Kingfisher
import FirebaseAuth

struct AccountView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var shareModel : ShareModel
    
    @Binding var selectedIndex: Int
    
    @State var name : String = ""
    
    @State var imageURL: URL? = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/1200px-Default_pfp.svg.png")
    
    @State var toggle = false
    
    var viewModel : AccountViewModel
    
    init(index : Binding<Int>){
        _selectedIndex = index
        let container = DependencyContainer()
        viewModel = AccountViewModel(fireStore: container.firestoreService, storage: container.storageService)
    }
    
    var body: some View {
        NavigationView {
            
            
            VStack(spacing: 0){
                Text("Tài khoản")
                    .font(.custom("Work Sans", size: 32))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack{
                    
                    KFImage(imageURL)
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
                    
                    Text(name)
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
                    
                    Button {
                        Task {
                            do {
                                try Auth.auth().signOut()
                                shareModel.userSession = nil
                                shareModel.isNotAuth = true
                                selectedIndex = 0
                            } catch {
                                print("Error signing out: \(error)")
                            }
                        }
                    } label: {
                        HStack{
                            Image("SignOut")
                                .padding(12)
                            
                            Text("Đăng xuất")
                                .font(.custom("Work Sans", size: 15))
                                .foregroundColor(.black)
                            
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: 56, alignment: .leading)
                        .background {
                            RoundedRectangle(cornerRadius: 36)
                                .fill(Color("Background5")
                                    .opacity(0.25))
                        }
                    }

                    
                    
                }
                .padding(.horizontal, 10)
                
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .onAppear{
            
            print("đây là on appear")
            
            guard let uid = shareModel.userSession?.user?.uid else { return }
            viewModel.getAccountOrCreate(uid: uid) { account in
                name = account.name ?? ""
                
                if let photoURL = account.image {
                    shareModel.userSession?.user?.photoURL = photoURL
                }
            }
        }
        .onChange(of: shareModel.userSession?.user?.photoURL) { newValue in
            if let newValue{
                if let url = URL(string: newValue) {
                    imageURL = url
                }
            }
        }
        .onChange(of: shareModel.userSession?.user?.displayName) { newValue in
            if let newValue{
                name = newValue
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(index: .constant(1))
            .environmentObject(ShareModel())
    }
}
