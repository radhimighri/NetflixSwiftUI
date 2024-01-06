//
//  SwiftUIVideoView.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 12/09/2023.
//

import SwiftUI
import AVKit

struct SwiftUIVideoView: View {
    //MARK: - Properties && Helpers
    var url: URL
    
    private var videoPlayer: AVPlayer {
        AVPlayer(url: url)
    }

    //MARK: - View
    var body: some View {
        VideoPlayer(player: videoPlayer)
    }
}

struct SwiftUIVideoView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIVideoView(url: exampleVideoURL)
    }
}
