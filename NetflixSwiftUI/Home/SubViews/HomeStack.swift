//
//  HomeStack.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 15/09/2023.
//

import SwiftUI

struct HomeStack: View {
    var vm: HomeVM
    
    var topRowSelection: HomeTopRow
    
    var selectedGenre: HomeGenre
    
    @Binding var movieDetailsToShow: Movie?
    
    @Binding var showPreviewFullScreen : Bool
    @Binding var previewStartingIndex: Int

    
    var body: some View {
        ForEach(vm.allCategories, id: \.self) { category in
            VStack {
                HStack {
                    Text(category)
                        .font(.title3)
                        .bold()
                    Spacer()
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    LazyHStack {
                        ForEach(vm.getMovies(forCat: category, andHomeTopRow: topRowSelection, andGenre: selectedGenre)) { movie in
                            
                            StandardHomeMovieView(movie: movie)
                                .frame(width: 135, height: 200)
//                                .padding(.horizontal, 20)
                                .onTapGesture {
                                    movieDetailsToShow = movie
                                }
                        }
                    }
                    
                }
            }
            .padding(.leading, 6)
            
        }
    }
}


struct HomeStack_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                HomeStack(
                    vm: HomeVM(),
                    topRowSelection: .home,
                    selectedGenre: .AllGenres,
                    movieDetailsToShow: .constant(nil),
                    showPreviewFullScreen: .constant(false),
                    previewStartingIndex: .constant(0)
                )
            }
            .foregroundColor(.white)
        }
    }
}
