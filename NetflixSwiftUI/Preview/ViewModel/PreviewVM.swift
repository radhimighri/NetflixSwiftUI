//
//  PreviewVM.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 18/09/2023.
//

import Foundation


class PreviewVM: ObservableObject {
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    
     func isCategoryLast(_ cat: String) -> Bool {
    let catCount = movie.categories.count
        if let index = movie.categories.firstIndex(of: cat) {
            if index + 1 != catCount
            {
                return false
            }
        }
        return true
    }
    
}
