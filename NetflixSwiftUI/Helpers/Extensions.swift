//
//  Extensions.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 17/09/2023.
//

import SwiftUI


extension LinearGradient {
    static let blackOpacityGradient =  LinearGradient(
        gradient: Gradient(colors:
                            [Color.black.opacity(0.0), Color.black.opacity(0.95)]),
        startPoint: .top,
        endPoint: .bottom)
}


extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}


extension View {
    func hidekeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
    // Hide or show the view based on a boolean value.
    // Example for visibility:
    // Text ("Label")
    //.isHidden(true)
    
    /// Example for complete removal:
    // Text ("Label")
    //.isHidden (true, remove: true)
    
    // - Parameters:
    //- hidden: Set to false to show the view. Set to 'true to hide the view.
    //- remove: Boolean value indicating whether or not to remove the view.
    
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
        
    }
    
    
}
