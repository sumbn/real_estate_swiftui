//
//  ShowImagesView.swift
//  AuthenWithFirebase
//
//  Created by daktech on 6/1/23.
//

import SwiftUI

struct ShowImagesView: View {
    var uiImage: UIImage
    @Binding var progress: Double
    var deleteImage: () -> Void
    
    var body: some View {
        ZStack{
            Image(uiImage: uiImage)
                .resizable()
                .cornerRadius(10)
                .aspectRatio(contentMode: .fit)
            
            ProgressView(value: progress)
                .progressViewStyle(CustomCircularProgressViewStyle(color: .white))
                .scaleEffect(0.5, anchor: .center)
        }
            .frame(maxWidth: 124.4, maxHeight: 70)
            .overlay(alignment: .topTrailing) {
                Button {
                    withAnimation {
                        deleteImage()
                    }
                    
                } label: {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(Color.black)
                        .background(
                            Circle()
                                .fill(Color.white)
                        )
                        .padding(7)
                }
            }
        
    }
}

//struct ShowImagesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowImagesView(uiImage: UIImage(systemName: "photo")!) {
//            
//        }
//    }
//}
