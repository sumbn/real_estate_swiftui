//
//  PostItemView.swift
//  AuthenWithFirebase
//
//  Created by daktech on 6/3/23.
//

import SwiftUI
import AVFoundation
import _AVKit_SwiftUI
import Kingfisher

struct PostItemView: View {
    @State private var images: [UIImage]?
    @State private var videoPlayer: AVPlayer?
    
    let postModel : PostModel
    var body: some View {
        
        VStack {
            ScrollView(.horizontal){
                HStack{
                    ForEach(postModel.imageURLs!, id: \.self) { image in
                        KFImage.url(URL(string: image))
                            .resizable()
                            .frame(width: 200, height: 200 * 9 / 16)
                    }
                    
                }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
       
    }
    
}

struct PostItemView_Previews: PreviewProvider {
    static var previews: some View {
        PostItemView(postModel: PostModel())
    }
}
