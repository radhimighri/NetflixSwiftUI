//
//  EpisodeView.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 13/09/2023.
//

import SwiftUI

struct EpisodeView: View {
    //MARK: - Properties && Helpers
    var episodes: [Episode]
    
    @Binding var showSeasonPicker: Bool
    @Binding var selectedSeason: Int
    
    func getEpisodes(forSeason season: Int) -> [Episode] {
        return episodes.filter({$0.season == season})
    }
    
    //MARK: - View
    var body: some View {
       
        VStack(spacing: 14) {
            ///Season Picker
           
            HStack {
                Button {
                    showSeasonPicker = true
                } label: {
                    Group {
                        Text("Season \(selectedSeason)")
                        Image(systemName: "chevron.down")
                    }
                    .font(.system(size: 16))
                }

                
                Spacer()
            }
            
            //Episodes list
            
            ForEach(getEpisodes(forSeason: selectedSeason)) { episode in
              
                VStack(alignment: .leading) {
                    //HStack with preview image, name, download image
                    HStack {
                        VideoPreviewImage(imageURL: episode.thumbnailURL, videoURL: episode.videoURL)
                            .frame(width: 120, height: 70)
                            .clipped()
                        
                        VStack(alignment: .leading) {
                            Text("\(episode.episodeNumber). \(episode.name)")
                                .font(.system(size: 16))
                            
                            Text("\(episode.length)")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
//                        .padding(.horizontal, 70)
                        
                        Spacer()
                        
                        Image(systemName: "arrow.down.to.line.alt")
                            .font(.system(size: 20))
                    }
                    //description
                    Text(episode.description)
                        .font(.system(size: 13))
                        .lineLimit(3)
                }
                .padding(.bottom, 10)
            }
            
            Spacer()
            
        }
        .foregroundColor(.white)
        .padding(.horizontal, 20)
    }
}


//MARK: - Previews
struct EpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            EpisodeView(episodes: allExamplEpisodes, showSeasonPicker: .constant(false), selectedSeason: .constant(1))
        }
    }
}
