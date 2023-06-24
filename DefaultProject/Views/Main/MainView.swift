//
//  MainView.swift
//  DefaultProject
//
//  Created by daktech on 6/9/23.
//

import SwiftUI

struct MainView: View {
    
    @State var isFSCShowPosting = false
    
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        
            ZStack{
                TabView(selection: $selectedIndex) {
                    HomeView()
                        .tabItem {
                            Image("HomePage")
                                .renderingMode(.template)
                            
                            Text("Trang chủ")
                                .font(.custom(workSansFont, size: 11))
                        }
                        .tag(0)
                    
                    GetAllPostView()
                        .tabItem {
                            Image("ManagingPostingNews")
                                .renderingMode(.template)
                            
                            Text("Quản lý tin")
                                .font(.custom(workSansFont, size: 11))
                        }
                        .tag(1)
                    
                    AccountView(index: $selectedIndex)
                        .tabItem {
                            Image("AccountPage")
                                .renderingMode(.template)
                            
                            Text("Tài khoản")
                                .font(.custom(workSansFont, size: 11))
                        }
                        .tag(2)
                }
                .accentColor(Color("Text3"))
                .onAppear{
                    UITabBar.appearance().backgroundColor = .white
                }
                
                VStack{
                    Button {
                        isFSCShowPosting = true
                    } label: {
                        HStack{
                            
                            Image("PostingNews")
                            
                            Text("Đăng tin")
                                .font(.custom(workSansFont, size: 17))
                                .bold()
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color("Text3"))
                        }
                    }
                }
                .frame(maxHeight: UIScreen.main.bounds.height / 5 * 4, alignment: .bottom)
                .padding(.bottom, 30)
            }
            .fullScreenCover(isPresented: $isFSCShowPosting) {
                PostingScreenView()
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ShareModel())
    }
}
