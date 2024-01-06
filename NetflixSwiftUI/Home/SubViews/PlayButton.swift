//
//  PlayButton.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 11/09/2023.
//

import SwiftUI

struct PlayButton: View {
    //MARK: - Properties && Helpers
    var text: String
    var imageName: String
    var backgroundColor: Color = Color.white
    
    var action: () -> Void

    //MARK: - View
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                
                Image(systemName: imageName)
                    .font(.headline)
                
                Text(text)
                    .bold()
                    .font(.system(size: 16))
                
                Spacer()
            }
            .padding(.vertical, 6)
            .foregroundColor(backgroundColor == .white ? .black : .white)
            .background(backgroundColor)
            .cornerRadius(3.0)
        }
    }
}


//MARK: - Previews
struct WhiteButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            PlayButton(text: "Play", imageName: "play.fill") {
                print("DEBUG::: Test play btn...")
            }
        }
    }
}
