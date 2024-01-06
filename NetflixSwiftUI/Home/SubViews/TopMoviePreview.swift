//
//  TopMoviePreview.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 11/09/2023.
//

import SwiftUI
import Kingfisher


struct TopMoviePreview: View {
    //MARK: - Properties && Helpers
    var movie: Movie
    
    
    //MARK: - Helpers
    func isCategoryLast(_ cat: String) -> Bool {
    let catCount = movie.categories.count
        if let index = movie.categories.firstIndex(of: cat) {
            if index + 1 != catCount
            {
                return false
            }
        }
        return true
    }
    
    
    //MARK: - View
    var body: some View {
        ZStack {
            KFImage(movie.thumbnailURL)
                .resizable()
                .scaledToFill()
                .clipped()
            
            VStack {
                Spacer()
                
                HStack {
                    ForEach(movie.categories, id: \.self) { category in
                        HStack {
                            Text(category)
                                .font(.footnote)
                            if !isCategoryLast(category) {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 3))
                            }
                        }
                    }
                }
                
                HStack {
                    Spacer()
                    SmallVerticalButton(text: "My List", isOnImage: "checkmark", isOffImage: "plus", isOn: false) {
                        print("DEBUG::: Test mylist button")
                    }
                    Spacer()
                    PlayButton(text: "Play", imageName: "play.fill") {
                        print("DEBUG::: Test play btn...")
                    }
                    .frame(width: 120)
                    Spacer()
                    SmallVerticalButton(text: "Info", isOnImage: "info.circle", isOffImage: "info.circle", isOn: true) {
                        print("DEBUG::: Test mylist button")
                    }
                    Spacer()
                }
                .padding(.vertical, 14)
            }
            .background(
                LinearGradient.blackOpacityGradient
                    .padding(.top, 250) //push down the gradient by 100
            )
            
        }
        .foregroundColor(.white)
    }
}

//MARK: - Previews
struct TopMoviePreview_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            TopMoviePreview(movie: exampleMovie1)
        }
    }
}
