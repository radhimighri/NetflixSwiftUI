//
//  TrailerPlayerView.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 18/09/2023.
//

import SwiftUI
import VideoPlayer


struct TrailerPlayerView: View {
    //MARK: - Properties && Helpers
    var videoURL: URL?
    
    @Binding var playVideo: Bool
    
    //MARK: - View
    var body: some View {
        if videoURL != nil {
            VideoPlayer(url: videoURL!, play: $playVideo)
        } else {
            Text("Could not load video")
                .bold()
                .foregroundColor(.white)
        }
    }
}

//MARK: - Previews
struct TrailerPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            TrailerPlayerView(videoURL: exampleVideoURL, playVideo: .constant(true))
        }
    }
}
