//
//  ComingSoon.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 17/09/2023.
//

import SwiftUI

struct ComingSoon: View {
    //MARK: - Properties && Helpers
    @State private var showNotificationsList = false
    
    @State private var movieDetailsToShow: Movie? = nil
    
    @State private var navBarHidden = false
    
    
    @State private var scrollOffset: CGFloat = 0.0
    
    @State private var activeIndex = 0
    
    @ObservedObject var vm = ComingSoonVM()
    
    func updateActiveIndex(fromScroll scroll: CGFloat) {
        if scroll < 105 { //Notifications bar height
            activeIndex = 0
        } else {
            let remove105 = scroll - 105
            
            let active = Int(remove105 / 410) + 1 /// 400 : row height, 10: default padding, +1: cause we start counting from index 0
            activeIndex = Int(active)
        }
    }

    //MARK: - View
    var body: some View {
        let movies = vm.movies.enumerated().map({ $0 }) ///this s'll give us an array of movies with index
        
        let scrollTrackingBinding = Binding {
            return scrollOffset //getter
        } set: { newValue in //setter
            scrollOffset = newValue
            updateActiveIndex(fromScroll: newValue)
        }

//        NavigationView {
            Group {
                ZStack {
                    Color.black
                        .edgesIgnoringSafeArea(.all)
                    
                    TrackableScrollView(.vertical ,showIndicators: false, contentOffset: scrollTrackingBinding) {
                  
                        LazyVStack {
                            NotificationsBar(showNotificationsList: $showNotificationsList)
                            
                            ForEach(movies, id: \.offset) { index, movie in ///offset: index of the movie
                                ComingSoonRow(movie: movie, movieDetailsToShow: $movieDetailsToShow)
                                    .frame(height: 400)
                                    .overlay(
                                        Group {
                                            index == activeIndex ? Color.clear : Color.black.opacity(0.8)
                                        }
                                            .animation(.easeInOut)
                                    )
                            }
                        }
                        .foregroundColor(.white)
                        
                        NavigationLink(
                            destination: Text("Notifications List"),
                            isActive: $showNotificationsList,
                            label: {
                                EmptyView()
                                
                            })
                        .navigationTitle("")
                        .navigationBarHidden(navBarHidden)
                        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { perform in
                            self.navBarHidden = true
                        }
                        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { perform in
                            self.navBarHidden = false
                        }
                    }
                    
//                    Text("ScrollOffSet: \(scrollOffset)")
//                        .background(Color.yellow)
                    
                    if movieDetailsToShow != nil {
                        MovieDetails(movie: movieDetailsToShow!, movieDetailsToShow: $movieDetailsToShow)
                    }
                }
                
             
        
            }
//        }
        
    }
}


//MARK: - Previews
struct ComingSoon_Previews: PreviewProvider {
    static var previews: some View {
       ComingSoon()
     }
}
