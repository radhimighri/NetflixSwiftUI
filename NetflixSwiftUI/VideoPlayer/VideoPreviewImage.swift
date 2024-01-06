//
//  VideoPreviewImage.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 13/09/2023.
//

import SwiftUI
import Kingfisher

struct VideoPreviewImage: View {
    //MARK: - Properties && Helpers
    var imageURL: URL
    var videoURL: URL
    
    @State private var showingVideoPlayer = false
    
    //MARK: - View
    var body: some View {
        
        ZStack {
            KFImage(imageURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
             
            Button {
//                showingVideoPlayer.toggle() //or
                showingVideoPlayer = true
            } label: {
                Image(systemName: "play.circle")
                    .foregroundColor(.white)
                    .font(.system(size: 40))
            }
            .sheet(isPresented: $showingVideoPlayer) {
                SwiftUIVideoView(url: videoURL)
            }

        }
    }
}


//MARK: - Previews
struct VideoPreviewImage_Previews: PreviewProvider {
    static var previews: some View {
        VideoPreviewImage(imageURL: exampleImageURL, videoURL: exampleVideoURL)
    }
}
