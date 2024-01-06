//
//  ComingSoonRow.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 18/09/2023.
//

import SwiftUI
import Kingfisher
import AVKit

struct ComingSoonRow: View {
    //MARK: - Properties
    var movie: Movie
    
    @Binding var movieDetailsToShow: Movie?
    
    let screenDims = UIScreen.main.bounds
    
    var player: AVPlayer {
        AVPlayer(url: URL(string: "https://www.radiantmediaplayer.com/media/big-buck-bunny-360p.mp4")!)
    }
    
    //MARK: - View
    
    var body: some View {
        VStack {
            Color.graySearchBackground
//            VideoPlayer(player: player)
                .frame(height: 200)
            
            VStack {
                HStack {
                    KFImage(movie.thumbnailURL)
                        .resizable()
                        .aspectRatio(contentMode:.fill)
                        .frame(width: screenDims.size.width/3, height: 75)
                        .clipped()
                    
                    Spacer ()
                    
                    Button(action: {
                        // remind me
                    }, label: {
                        VStack(spacing: 6) {
                            Image(systemName: "bell")
                                .font(.title3)
                            Text("Remind Me")
                            
                        }
                    })
                    .padding (.horizontal)
                    
                    Button(action: {
                        movieDetailsToShow = movie
                    }, label: {
                        VStack(spacing: 6) {
                            Image(systemName: "info.circle")
                                .font(.title3)
                            Text("Info")
                            
                        }
                    })
                    .padding (.trailing, 24)
                }
                .font(.caption)
                
                VStack(alignment: .leading) {
                    Text(movie.name)
                        .font(.title2)
                        .bold()
                    Text(movie.episodeDescriptionDisplay)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
        
            }
            .foregroundColor(.white)
            .padding(.horizontal)
        }
    }
}


struct ComingSoonRow_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            ComingSoonRow(movie: exampleMovie1, movieDetailsToShow: .constant(nil))
        }
    }
}
