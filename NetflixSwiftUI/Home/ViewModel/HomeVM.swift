//
//  HomeVM.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 09/09/2023.
//

import Foundation


class HomeVM: ObservableObject {
    
    @Published var movies : [String : [Movie]] = [:]
    
    public var allCategories: [String] {
        movies.keys.map({String($0)})
    }
    
    public var allGenres: [HomeGenre] = [.AllGenres, .Actions, .Comedy, .Horror, .Thriller]
    
    public func getMovies(forCat cat: String, andHomeTopRow homeRow: HomeTopRow, andGenre genre: HomeGenre) -> [Movie] {
        switch homeRow {
            
        case .home:
            return movies[cat] ?? []

        case .tvShows:
            return (movies[cat] ?? []).filter({($0.movieType == .tvShow) && ($0.genre == genre)})

        case .movies:
            return (movies[cat] ?? []).filter({($0.movieType == .movie) && ($0.genre == genre)})
            
        case .myList:
            return movies[cat] ?? []
            //TODO: Setup MyList Properly
        }
    }
    
    init() {
        setupMovies()
    }
    
    private func setupMovies() {
//        movies["Trending Now"] = [exampleMovie1]
        movies["Trending Now"] = exampleMovies
        movies["Stand-Up Comedy"] = exampleMovies.shuffled()
        movies["New Releases"] = exampleMovies.shuffled()
        movies["Watch It Again"] = exampleMovies.shuffled()
        movies["Sci-Fi Movies"] = exampleMovies.shuffled()
    }
    
    
 
}
