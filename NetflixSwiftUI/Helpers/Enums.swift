//
//  Enums.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 16/09/2023.
//

import Foundation


enum HomeTopRow: String, CaseIterable { ///we adopt the CaseIterable protocol to enable the iteration via ForEach loop
    case home = "Home"
    case tvShows = "TV Shows"
    case movies = "Movies"
    case myList = "My List"
    
}

enum HomeGenre: String {
    case AllGenres
    case Actions
    case Comedy
    case Horror
    case Thriller
}


enum CustomTab: String {
    case episodes = "EPISODES"
    case trailers = "TRAILERS & MORE"
    case more = "MORE LIKE THIS"
}

enum MovieType {
    case movie
    case tvShow
}


enum ViewState {
    case empty
    case loading
    case ready
    case error
}
