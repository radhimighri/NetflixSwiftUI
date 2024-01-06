//
//  SearchVM.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 17/09/2023.
//

import Foundation


class SearchVM: ObservableObject {
    
    @Published var isLoading: Bool = false
    
    @Published var viewState: ViewState = .ready //cause every time the user clicks on the search bar and before starts typing any thing we gonna directly display the popular search results

    @Published var isShowingPopularMovies = true

    ///so we gonna either get the popularMovies list or the searchResults list
    @Published var popularMovies: [Movie] = []
    @Published var searchResults: [Movie] = []
    
    init() {
        getPopularMovies()
    }
    
    public func updateSearchText(with text: String) {
        setViewState(to: .loading)
        
        if text.count > 0 {
            isShowingPopularMovies = false
            getSearchResults(forText: text)
        } else {
            isShowingPopularMovies = true
            setViewState(to: .empty)
        }
    }
    
    private func setViewState(to state: ViewState) {
        self.isLoading = true;
         DispatchQueue.main.async {
            self.viewState = state
            self.isLoading = state == .loading
        }
    }
    
    private func getPopularMovies() {
        self.popularMovies = generateMovies(40)
    }
    
    private func getSearchResults(forText text: String) {
        let haveResults = Int.random(in: 0...3) ///25% we dont get results
 
        DispatchQueue.main.async {
            if haveResults == 0 {
                //emptyView
                self.searchResults = []
                self.setViewState(to: .empty)
            } else {
                //ready view
                let movies = generateMovies(21)
                self.searchResults = movies
                self.setViewState(to: .ready)
            }
        }
        
    }
    
}
