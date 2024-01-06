//
//  PopularMovieView.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 17/09/2023.
//

import SwiftUI
import Kingfisher


struct PopularMovieView: View {
    //MARK: - Properties
    var movie: Movie
    
    @Binding var movieDetailsToShow: Movie?

    
    //MARK: - View
    var body: some View {
        
        GeometryReader { proxy in
            HStack {
                KFImage(movie.thumbnailURL)
                    .resizable()
                    .frame(width: proxy.size.width / 3)
                
                Text(movie.name)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "arrowtriangle.right.fill")
                }
                .padding(.trailing, 20)

            }
            .foregroundColor(.white)
            .onTapGesture {
                self.movieDetailsToShow = movie
            }
        }
    }
}

//MARK: - reviews
struct PopularMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            PopularMovieView(movie: exampleMovie1, movieDetailsToShow: .constant(nil))
                .frame(height: 75)
        }
    }
}
