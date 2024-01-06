//
//  MoreLikeThis.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 12/09/2023.
//

import SwiftUI

struct MoreLikeThis: View {
    
    //MARK: - Properties && Helpers
    var movies: [Movie]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    //MARK: - View
    var body: some View {
        LazyVGrid(columns: columns) {
            
            ForEach(0..<movies.count, id: \.self) { index in
                StandardHomeMovieView(movie: movies[index])
            }
        }
        
    }
}


//MARK: - Previews
struct MoreLikeThis_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            MoreLikeThis(movies: exampleMovies)
        }
    }
}
