//
//  SearchView.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 17/09/2023.
//

import SwiftUI

struct SearchView: View {
    //MARK: - Properties
    @ObservedObject var vm = SearchVM()
    
    @State private var searchText: String = ""
    
    @State private var movieDetailsToShow: Movie? = nil

    //MARK: - View
    var body: some View {
        
        let searchTextBinding = Binding {
            return searchText //getter
        } set: { //setter
            searchText = $0
            vm.updateSearchText(with: $0)
        }
         return ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                SearchBar(text: searchTextBinding, isLoading: $vm.isLoading)
                    .padding()
                
                ScrollView {
                    if vm.isShowingPopularMovies {
                        PopularList(movies: vm.popularMovies, movieDetailsToShow: $movieDetailsToShow)
                    }
                    if vm.viewState == .empty {
                        Text("Your search did not have any results.")
                            .bold()
                            .padding(.top, 150)
                    } else if vm.viewState == .ready && !vm.isShowingPopularMovies {
                       
                        VStack {
                            HStack {
                                Text("Movies & TV")
                                    .bold()
                                    .font(.title3)
                                    .padding(.leading, 12)
                                Spacer()
                            }
                            
                            
                            SearchResultsGrid(movies: vm.searchResults, movieDetailsToShow: $movieDetailsToShow)
                                

                        }
                        
                     }
                    
                }
                
                Spacer()
            }
             
             if movieDetailsToShow != nil {
                 MovieDetails(movie: movieDetailsToShow!, movieDetailsToShow: $movieDetailsToShow)
             }
            
        }
        .foregroundColor(.white)
    }
}


//MARK: - Previews

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        SearchView()
    }
}


//MARK: - Sub-Views
struct PopularList: View {
    
    var movies: [Movie]
    
    @Binding var movieDetailsToShow: Movie?

    var body: some View {
        
        VStack {
            HStack {
                Text("Popular Searches")
                    .bold()
                    .font(.title3)
                    .padding(.leading, 12)
                
                Spacer()
            }
            
            LazyVStack {
                ForEach(movies, id: \.id) { movie in
                    PopularMovieView(movie: movie, movieDetailsToShow: $movieDetailsToShow)
                        .frame(height: 75)
                }
            }
        }
    }
}
