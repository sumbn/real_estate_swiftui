//
//  EditAvatarView.swift
//  DefaultProject
//
//  Created by daktech on 6/13/23.
//

import SwiftUI
import Kingfisher

struct EditAvatarView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var shareModel : ShareModel
    
    var viewModel : EditAvatarViewModel
    
    @State var isShowPhotoPicker = false
    
    @State var imageURL: URL? = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/1200px-Default_pfp.svg.png")
    
    @State var uiImage: UIImage = UIImage(named: "chooseImage")!{
        didSet{
            viewModel.updateImage(uiImage: uiImage, path: Constants.pathAccount, document: shareModel.userSession?.user?.uid ?? "not found", param: "image"){ path in
                shareModel.userSession?.user?.photoURL = path
            }
            
        }
    }
    
    init() {
        let container = DependencyContainer()
        
        self.viewModel = EditAvatarViewModel(firestore: container.firestoreService, storage: container.storageService)
    }
    
    var body: some View {
        VStack{
            HStack{
                KFImage(imageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 74, height: 74)
                    .clipShape(Circle())
                    .overlay(alignment: .bottomTrailing) {
                        
                        Button {
                            isShowPhotoPicker = true
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
        .fullScreenCover(isPresented: $isShowPhotoPicker, content: {
            ImagePicker(typePicker: .image, getUIImage: { uiImage in
                self.uiImage = uiImage
            })
        })
        .padding(.horizontal, 20)
        .frame(maxHeight: .infinity, alignment: .top)
        .onChange(of: shareModel.userSession?.user?.photoURL) { newValue in
            if let newValue {
                if let url = URL(string: newValue) {
                    imageURL = url
                }
            }
        }
        .onAppear{
            if let urlString = shareModel.userSession?.user?.photoURL{
                
                print("on appear \(urlString)")
                if let url = URL(string: urlString) {
                    imageURL = url
                }
            }
        }
    }
}

struct EditAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        EditAvatarView()
            .environmentObject(ShareModel())
    }
}
