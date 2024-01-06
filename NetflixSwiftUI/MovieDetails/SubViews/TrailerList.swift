//
//  TrailerList.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 13/09/2023.
//

import SwiftUI

struct TrailerList: View {
    //MARK: - Properties && Helpers
    var trailers: [Trailer]
    
    let screenDims = UIScreen.main.bounds
    
    //MARK: - View
    var body: some View {
        
        VStack {
            
            ForEach(trailers) { trailer in
                
                VStack (alignment: .leading) {
                    VideoPreviewImage(imageURL: trailer.thumbnailImageURL, videoURL: trailer.videoURL)
                        .frame(maxWidth: screenDims.width)
                    
                    Text(trailer.name)
                        .font(.headline)
                }
                .foregroundColor(.white)
                .padding(.bottom, 10)
           
            }
         
        }
    }
}


//MARK: - Previews
struct TrailerList_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            TrailerList(trailers: exampleTrailers)
        }
    }
}
