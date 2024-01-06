//
//  HomeView.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 09/09/2023.
//

import SwiftUI

struct HomeView: View {
    //MARK: - Properties && Helpers
    @ObservedObject var vm = HomeVM()
    let screenDims = UIScreen.main.bounds
    
    @State private var movieDetailsToShow: Movie? = nil
    
    @State private var topRowSelection: HomeTopRow = .home
    @State private var homeGenre: HomeGenre = .AllGenres
    
    @State private var showTopRowSelection = false ///this wil be the menu changing the toprow
    @State private var showGenreSelection = false ///this wil be the menu showing the options for the genre
    
    
    @Binding var showPreviewFullScreen : Bool
    @Binding var previewStartingIndex: Int

    
    //MARK: - View
    var body: some View {
        
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                
                LazyVStack { //main VStack
                     
                    TopRowButtons(topRowSelection: $topRowSelection, homeGenre: $homeGenre, showTopRowSelection: $showTopRowSelection, showGenreSelection: $showGenreSelection)
                        .zIndex(0)
                    
                    TopMoviePreview(movie: exampleMovie2)
                        .frame(width: screenDims.width)
                        .padding(.top, -110)
                        .zIndex(-1.0) // put txhis ZStack child behind its previous child (in this example Text(''))
                   
                    MoviePreviewRow(
                        movies: exampleMovies,
                    showPreviewFullScreen: $showPreviewFullScreen,
                    previewStartingIndex: $previewStartingIndex)
                    
                    HomeStack(
                        vm: vm,
                        topRowSelection: topRowSelection,
                        selectedGenre: homeGenre,
                        movieDetailsToShow: $movieDetailsToShow,
                    showPreviewFullScreen: $showPreviewFullScreen,
                    previewStartingIndex: $previewStartingIndex)
                }
            }
            
            if movieDetailsToShow != nil {
                MovieDetails(movie: movieDetailsToShow!, movieDetailsToShow: $movieDetailsToShow)
                    .animation(.easeIn)
                    .transition(.opacity)
            }
            
            if showTopRowSelection {
                Group {
                    Color.black
                        .opacity(0.9)
                    
                    VStack(spacing: 40) {
                        
                        Spacer()
                        
                        ForEach (HomeTopRow.allCases, id: \.self) { topRowItem in
                            Button (action: {
                                topRowSelection = topRowItem
                                showTopRowSelection = false
                            }, label: {
                                if topRowItem == topRowSelection {
                                    Text ("\(topRowItem.rawValue)")
                                        .bold()
                                } else {
                                    Text ("\(topRowItem.rawValue)")
                                        . foregroundColor(.gray)
                                }
                            })
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            showTopRowSelection = false
                        }, label: {
                            Image (systemName: "xmark.circle.fill")
                                .font(.system(size: 40))
                        })
                        .padding(.bottom, 30)
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .font(.title2)
            }
            
            if showGenreSelection {
                Group {
                    Color.black
                        .opacity(0.9)
                    
                    VStack(spacing: 40) {
                        
                        Spacer()
                        
                        ScrollView {
                            ForEach (vm.allGenres, id: \.self) { genre in
                                Button (action: {
                                    homeGenre = genre
                                    showGenreSelection = false
                                }, label: {
                                    if homeGenre == genre {
                                        Text ("\(genre.rawValue)")
                                            .bold()
                                    } else {
                                        Text ("\(genre.rawValue)")
                                            . foregroundColor(.gray)
                                    }
                                })
                                .padding(.bottom, 40)
                            }

                        }
                        
                        Spacer()
                        
                        Button(action: {
                            showGenreSelection = false
                        }, label: {
                            Image (systemName: "xmark.circle.fill")
                                .font(.system(size: 40))
                        })
                        .padding(.bottom, 30)
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .font(.title2)
            }

        }
        .foregroundColor(.white)
    }
}


//MARK: - Previews
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            showPreviewFullScreen: .constant(false),
            previewStartingIndex: .constant(0)
        )
    }
}

//MARK: - Sub-Views

//MARK: - TopRowButtons
struct TopRowButtons: View {
    
    @Binding var topRowSelection: HomeTopRow
    @Binding var homeGenre: HomeGenre
    
    
    @Binding var showTopRowSelection: Bool
    @Binding var showGenreSelection: Bool
    
    
    var body: some View {
        
        switch topRowSelection {
        case .home:
            HStack {
                Button(action: {
                    topRowSelection = .home
                }, label: {
                    Image("netflix-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                })
                //            .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                Button(action: {
                    topRowSelection = .tvShows
                }, label: {
                    Text("TV Shows")
                })
                .buttonStyle (PlainButtonStyle())
                
                Spacer ()
                
                Button(action: {
                    topRowSelection = .movies
                }, label: {
                    Text("Movies")
                })
                .buttonStyle(PlainButtonStyle())
                
                Spacer ()
                
                Button(action: {
                    topRowSelection = .myList
                }, label: {
                    Text("My List")
                })
                .buttonStyle(PlainButtonStyle())
            }
            //        .background(Color.black)
            .padding(.leading, 10)
            .padding(.trailing, 30)
            
        case .myList, .tvShows, .movies:
            HStack {
                Button(action: {
                    topRowSelection = .home
                }, label: {
                    Image("netflix-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                })
                //            .buttonStyle(PlainButtonStyle())
                
                
                HStack(spacing: 20) {
                    Button(action: {
                        showTopRowSelection = true
                    }, label: {
                        HStack {
                            Text(topRowSelection.rawValue)
                                .font(.system(size: 18))
                            Image(systemName: "triangle.fill")
                                .font(.system(size: 10))
                                .rotationEffect(.degrees(180),anchor: .center)
                        }
                    })
                    .buttonStyle (PlainButtonStyle())
                    
                    Button(action: {
                        showGenreSelection = true
                    }, label: {
                        HStack {
                            Text(homeGenre.rawValue)
                                .font(.system(size: 12))
                            
                            Image(systemName: "triangle.fill")
                                .font(.system(size: 6))
                                .rotationEffect(.degrees(180),anchor: .center)
                        }
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer ()
                }
                
                
                
                
                
            }
            .padding(.leading, 30)
            .padding(.trailing, 30)
         }
    }
}
