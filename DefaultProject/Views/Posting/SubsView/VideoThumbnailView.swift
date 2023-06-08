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
    @Binding var progress: Double
    
    let deleteVideo: () -> Void
    
    init(url: URL, progress: Binding<Double> ,deleteVideo: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: VideoThumbnailViewModel(url: url))
        self.deleteVideo = deleteVideo
        self._progress = progress
    }
    
    var body: some View {
        
        HStack{
            if let image = viewModel.thumbnailImage {
                ZStack{
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    ProgressView(value: progress)
                        .progressViewStyle(CustomCircularProgressViewStyle(color: .white))
                        .scaleEffect(0.5, anchor: .center)
                    
                }
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
                    .font(.system(size: 20, weight: .bold))
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

struct CustomCircularProgressViewStyle: ProgressViewStyle {
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? 0.0
        
        return ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), style: StrokeStyle(lineWidth: 10))
            
            Circle()
                .trim(from: 0.0, to: CGFloat(progress))
                .stroke(color, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .rotationEffect(Angle(degrees: -90))
        }
        .rotationEffect(Angle(degrees: 90))
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



