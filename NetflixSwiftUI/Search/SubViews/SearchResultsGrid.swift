//
//  SearchResultsGrid.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 17/09/2023.
//

import SwiftUI

struct SearchResultsGrid: View {
    //MARK: - Properties
    var movies: [Movie]
    
    @Binding var movieDetailsToShow: Movie?

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    //MARK: - View
    var body: some View {
        
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(movies, id: \.id) { movie in
                StandardHomeMovieView(movie: movie)
                    .frame(height: 160)
                    .onTapGesture {
                        movieDetailsToShow = movie
                    }
            }
        }
    }
}

//MARK: - View
struct SearchResultsGrid_Previews: PreviewProvider {
    static var previews: some View {
   
      
            SearchResultsGrid(movies: generateMovies(25), movieDetailsToShow: .constant(nil))
     }
}
