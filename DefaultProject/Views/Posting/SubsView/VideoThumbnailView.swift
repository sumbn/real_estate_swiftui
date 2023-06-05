//
//  VideoThumbnailView.swift
//  AuthenWithFirebase
//
//  Created by daktech on 6/2/23.
//

import SwiftUI
import AVFoundation

class VideoThumbnailViewModel: ObservableObject {
    @Published var thumbnailImage: UIImage?
    
    init(url: URL) {
        let asset = AVAsset(url: url)
        asset.generateThumbnail { image in
            DispatchQueue.main.async {
                self.thumbnailImage = image
            }
        }
    }
}

struct VideoThumbnailView: View {
    @StateObject private var viewModel: VideoThumbnailViewModel
    let deleteVideo: () -> Void
    
    init(url: URL, deleteVideo: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: VideoThumbnailViewModel(url: url))
        self.deleteVideo = deleteVideo
    }
    
    var body: some View {
        
        HStack{
            if let image = viewModel.thumbnailImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                ProgressView()
            }
        }
        .overlay(alignment: .topTrailing) {
            Button {
                withAnimation {
                    deleteVideo()
                }
                
            } label: {
                Image(systemName: "x.circle.fill")
                    .foregroundColor(Color.black)
//                    .bold()
                    .background(
                        Circle()
                            .fill(Color.white)
                    )
                    .padding(7)
            }
        }
           
    }
}

extension AVAsset {
    
    func generateThumbnail(completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            let imageGenerator = AVAssetImageGenerator(asset: self)
            let time = CMTime(seconds: 0.0, preferredTimescale: 600)
            let times = [NSValue(time: time)]
            imageGenerator.generateCGImagesAsynchronously(forTimes: times, completionHandler: { _, image, _, _, _ in
                if let image = image {
                    completion(UIImage(cgImage: image))
                } else {
                    completion(nil)
                }
            })
        }
    }
}


