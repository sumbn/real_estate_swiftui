//
//  ShowImagesView.swift
//  AuthenWithFirebase
//
//  Created by daktech on 6/1/23.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct ShowImagesView: View {
    var uiImage: UIImage
    var deleteImage: () -> Void
    
    var body: some View {
        Image(uiImage: uiImage)
            .resizable()
            .cornerRadius(10)
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 124.4, maxHeight: 70)
            .overlay(alignment: .topTrailing) {
                Button {
                    withAnimation {
                        deleteImage()
                    }
                    
                } label: {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(Color.black)
//                        .bold()
                        .background(
                            Circle()
                                .fill(Color.white)
                        )
                        .padding(7)
                }
            }
        
    }
}

struct ShowImagesView_Previews: PreviewProvider {
    static var previews: some View {
        ShowImagesView(uiImage: UIImage(systemName: "photo")!) {
            
        }
    }
}
