//
//  MoviePreviewRow.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 18/09/2023.
//

import SwiftUI

struct MoviePreviewRow: View {
    //MARK: - Properties && Helpers
    var movies: [Movie]
    
    @Binding var showPreviewFullScreen : Bool
    @Binding var previewStartingIndex: Int

    
    //MARK: - View
    var body: some View {
        VStack(alignment: .leading) {
            Text("Previews")
                .font(.title3)
                .bold()
                .foregroundColor(.white)
                .padding(.leading, 6)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(0..<movies.count) { movieIndex in
//                        Text(movies[movieIndex].name.uppercased())
                        MoviePreviewCell(movie: movies[movieIndex])
                            .frame(width: 120, height: 120)
                            .padding(.trailing, 14)
                            .padding(.leading, 6)
                            .onTapGesture {
                                previewStartingIndex = movieIndex
                                showPreviewFullScreen = true
                            }
                    }
                }
            }
        }
        .frame(height: 185)
//        .foregroundColor(.white)
    }
}

//MARK: - Preview
struct MoviePreviewRow_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            MoviePreviewRow(
                movies: exampleMovies,
                showPreviewFullScreen: .constant(false),
                previewStartingIndex: .constant(0)
            )
        }
    }
}
