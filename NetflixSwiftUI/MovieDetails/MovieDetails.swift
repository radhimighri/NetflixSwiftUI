//
//  MovieDetails.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 11/09/2023.
//

import SwiftUI

struct MovieDetails: View {
    //MARK: - Properties && Helpers
    var movie: Movie
    
    let screenDims = UIScreen.main.bounds
    
    @State private var showSeasonPicker = false ///source of truth
    @State private var selectedSeason = 1 ///source of truth
    
    
    @Binding var movieDetailsToShow: Movie? ///throught this Binding var our MovieDetails now has the read and write access to make changes on this State variable "MovieDetailsToShow"
    
    //MARK: - Views
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            // close this view
                            movieDetailsToShow = nil
                        }, label: {
                            Image(systemName: "xmark.circle")
                                .font(.system(size: 28))
                        })
                    }
                    .padding(.horizontal, 22)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            StandardHomeMovieView(movie: movie)
                                .frame(width: screenDims.width / 2.5)
                            
                            MovieInfoSubheadline(movie: exampleMovie3)
                            
                            if movie.promotionHeadline != nil {
                                Text(movie.promotionHeadline!)
                                    .bold()
                                    .font(.headline)
                            }
                            
                            PlayButton(text: "Play", imageName: "play.fill", backgroundColor: .red) {
                                print("DEBUG::: Test ;ovie detail play btn..")
                            }
                            
                            
                            CurrentEpisodeInfoView(movie: movie)
                            
                            CastInfoView(cast: movie.cast, creators: movie.creators)
                            
                            HStack(spacing: 60) {
                                SmallVerticalButton(text: "My List", isOnImage:
                                                        "checkmark", isOffImage: "plus", isOn: true) {
                                }
                                SmallVerticalButton(text: "Rate", isOnImage:
                                                        "hand.thumbsup.fill", isOffImage: "hand.thumbsup",
                                                    isOn: true) {
                                }
                                SmallVerticalButton(text: "Share", isOnImage:
                                                        "square.and.arrow.up", isOffImage:
                                                        "square.and.arrow.up", isOn: true) {
                                    //
                                }
                                
                                Spacer()
                            }
                            .padding(.leading, 20)
                            
                            
                            CustomTabSwitcher(tabs: [.episodes, .trailers, .more], movie: movie, showSeasonPicker: $showSeasonPicker, selectedSeason: $selectedSeason)
                            
                        }
                        .padding(.horizontal, 10)
                    }
                    
                    Spacer()
                }
                .foregroundColor(.white)
                
                if showSeasonPicker {
                   
                    Group {
                        Color.black.opacity(0.95)
                        
                        VStack (spacing: 40) {
                            Spacer ()
                            ForEach (0..<(movie.numberOfSeasons ?? 0), id: \.self) { season in
                                Button {
                                    self.selectedSeason = season + 1
                                    self.showSeasonPicker = false
                                } label: {
                                    Text ("Season \(season + 1)")
                                        .foregroundColor(selectedSeason == season + 1 ? .white : .gray)
                                        .bold()
                                        .font(selectedSeason == season + 1 ? .title : .title2)
                                }
                                
                            }
                            Spacer ()
                            
                            Button {
                                self.showSeasonPicker = false
                                
                            } label: {
                                Image (systemName: "x.circle.fill")
                                    .foregroundColor(.white)
                                    .font (.system(size: 40))
                                    .scaleEffect(x: 1.1)
                                    .padding(.bottom, 30)
                            }
                            
                            
                        }
                    }
                    .edgesIgnoringSafeArea(.all)

 
                }
            }
        }
        
    }
}


//MARK: - Previews
struct MovieDetails_Previews: PreviewProvider {
    
    static var previews: some View {
        MovieDetails(movie: exampleMovie1, movieDetailsToShow: .constant(nil))
    }
}


//MARK: - Sub-Views

//MARK: - MovieInfoSubheadline
struct MovieInfoSubheadline: View {
    var movie: Movie
    
    var body: some View {
        HStack (spacing: 20) {
            Image(systemName: "hand.thumbsup.fill")
                .foregroundColor(.white)
            
            Text(String(movie.year))
            
            RatingView(rating: movie.rating)
            
            Text(movie.numberOfSeasonsDisplay)
            
            ResolutionLabelView()
        }
        .foregroundColor(.gray)
        .padding(.vertical, 6)
    }
}

//MARK: - RatingView
struct RatingView: View {
    var rating: String
    

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
            
            Text(rating)
                .foregroundColor(.white)
                .font(.system(size: 12))
                .bold()
        }
        .frame(width: 50, height: 20)
    }
}

//MARK: - ResolutionLabelView
struct ResolutionLabelView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray.opacity(0.7))
            
            Text("HD")
                .foregroundColor(.white)
                .font(.system(size: 12))
                .bold()
        }
        .frame(width: 50, height: 20)
    }
}

struct CastInfoView: View {
    var cast: String
    var creators: String

    var body: some View {
        VStack {
            HStack {
                Text("Cast: \(cast)")
                
                Spacer()
            }
            
            HStack {
                Text("Creators: \(creators)")
                
                Spacer()
            }
        }
        .font(.caption)
        .foregroundColor(.gray)
        .padding(.vertical, 10)
    }
}

struct CurrentEpisodeInfoView: View {
    var movie: Movie

    var body: some View {
        
        ///Current Episode Information
        ///1. Default or :
        ///2. Personalized - where the user currently is
        Group {
            HStack {
                Text(movie.episodeInfoDisplay)
                    .bold()
                
                Spacer()
            }
            .padding(.vertical, 4)
            
            HStack {
                Text(movie.episodeDescriptionDisplay)
                    .font(.subheadline)
                
                Spacer()
            }
        }
    }
}
