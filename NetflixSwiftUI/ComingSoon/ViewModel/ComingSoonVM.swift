//
//  ComingSoonVM.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 18/09/2023.
//

import Foundation


class ComingSoonVM: ObservableObject {
    
    @Published var movies: [Movie] = []
    
    init() {
        self.movies = generateMovies(20)
    }
    
    
}
