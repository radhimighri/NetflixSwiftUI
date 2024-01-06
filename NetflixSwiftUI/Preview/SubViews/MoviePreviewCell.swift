//
//  MoviePreviewCell.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 18/09/2023.
//

import SwiftUI
import Kingfisher


struct MoviePreviewCell: View {
    //MARK: - Properties && Helpers
    var movie: Movie
    
//    let colors: [Color] = [.yellow, .gray, .pink, .red, .blue, .green, .orange]
    
    //MARK: - View
    var body: some View {
        ZStack(alignment: .bottom) {
            KFImage(movie.thumbnailURL)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(lineWidth: 3.0)
//                        .foregroundColor(colors.randomElement()?.opacity(0.6))
                        .foregroundColor(movie.accentColor.opacity(0.6))
            )
            
            Image(movie.previewImageName)
                .resizable()
                .scaledToFit()
                .offset(y: -20)
                .frame(height: 65)
        }
    }
}


//MARK: - Previews
struct MoviePreviewCell_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            MoviePreviewCell(movie: exampleMovie1)
                .frame(width: 200, height: 50)
        }
    }
}
