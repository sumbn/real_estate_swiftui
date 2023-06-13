//
//  EditAvatarView.swift
//  DefaultProject
//
//  Created by daktech on 6/13/23.
//

import SwiftUI

struct EditAvatarView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var shareModel : ShareModel
    
    var body: some View {
        VStack{
            HStack{
                Image("chooseImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 74, height: 74)
                    .clipShape(Circle())
                    .overlay(alignment: .bottomTrailing) {
                        
                        Button {
                            
                        } label: {
                            Image("PickPhoto")
                        }
                    }
                
                Text(shareModel.userSession?.user?.displayName ?? "Test")
                    .font(.custom("Work Sans", size: 20))
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image("EditProfileInfomation")
                }

            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 20)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct EditAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        EditAvatarView()
            .environmentObject(ShareModel(fireStore: FirestoreService()))
    }
}
