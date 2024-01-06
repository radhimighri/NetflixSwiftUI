//
//  StandardHomeMovieView.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 09/09/2023.
//

import SwiftUI
import Kingfisher


struct StandardHomeMovieView: View {
 
    //MARK: - Properties && Helpers
    var movie: Movie

    //MARK: - View
    var body: some View {
//        Text("StandardHomeMovieView!")
        KFImage(movie.thumbnailURL)
            .resizable()
//            .scaledToFill()
    }
}

//MARK: - Previews
struct StandardHomeMovieView_Previews: PreviewProvider {
    static var previews: some View {
        StandardHomeMovieView(movie: exampleMovie1)
            .frame(width: 200, height: 300)
    }
}
