//
//  CustomTabSwitcher.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 12/09/2023.
//

import SwiftUI

struct CustomTabSwitcher: View {
    //MARK: - Properties && Helpers

    @State private var currentTab: CustomTab = .episodes ///track which tab is already selected
    
    var tabs: [CustomTab]
    var movie: Movie
    
    @Binding var showSeasonPicker: Bool
    @Binding var selectedSeason: Int


    //MARK: - Helpers
    func widthforTab(_ tab: CustomTab) -> CGFloat {
        let string = tab.rawValue
        return string.widthOfString(usingFont: .systemFont(ofSize: 16, weight:
                .bold))
    }
    //MARK: - View
    var body: some View {
        VStack {
            //Custom tab picker
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(tabs, id: \.self) { customTab in
                        VStack {
                            //Red bar
                            Rectangle()
                                .frame(width: widthforTab(customTab), height: 6)
                                .foregroundColor(customTab == currentTab ? .red : .clear)
                            //Button
                            Button {
                                currentTab = customTab
                            } label: {
                                Text(customTab.rawValue)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(customTab == currentTab ? .white : .gray)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: widthforTab(customTab), height: 30)

                        }
                    }
                }
        

            }
            
            //Selected View
            switch currentTab {
            case .episodes:
                EpisodeView(episodes: movie.episodes ?? [], showSeasonPicker: $showSeasonPicker, selectedSeason: $selectedSeason)
            case .trailers:
                TrailerList(trailers: movie.trailers)
            case .more:
                MoreLikeThis(movies: movie.moreLikeThisMovies)
            }
            
            
        }
        .foregroundColor(.white)
    }
}

//MARK: - Previews
struct CustomTabSwitcher_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            CustomTabSwitcher(tabs: [.episodes, .trailers, .more], movie: exampleMovie1, showSeasonPicker: .constant(false), selectedSeason: .constant(1))
        }
    }
}



 
