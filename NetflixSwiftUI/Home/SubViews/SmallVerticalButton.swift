//
//  SmallVerticalButton.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 11/09/2023.
//

import SwiftUI

struct SmallVerticalButton: View {
    //MARK: - Properties && Helpers
    var text: String
    
    var isOnImage: String
    var isOffImage: String
    var color: Color = .white
    var isOn: Bool
    
    var imageName: String {
        return isOn ? isOnImage : isOffImage
    }
    
     var action: () -> Void
    
    //MARK: - View
    var body: some View {
        Button(action: {action() }) {
            VStack {
                Image(systemName: imageName)
                    .foregroundColor(color)
                
                Text(text)
                    .foregroundColor(color)
                    .font(.system(size: 14))
                    .bold()
            }
        }
    }
}


//MARK: - Previews
struct SmallVerticalButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            SmallVerticalButton(text: "My List", isOnImage: "checkmark", isOffImage: "plus", isOn: false) {
                print("ss")
            }
        }
    }
}
