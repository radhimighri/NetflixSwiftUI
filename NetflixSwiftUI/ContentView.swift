//
//  ContentView.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 09/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - Properties && Helpers
    @State private var showPreviewFullScreen = false
    @State private var previewStartingIndex: Int = 0
    
    @State private var previewCurrentPos: CGFloat = 1000
    @State private var previewNewPos: CGFloat = 1000
    
    @State private var previewHorizontalDragActive: Bool = false

    
    let screenDims = UIScreen.main.bounds
    
    init() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor.black
    }
    
    //MARK: - View
    var body: some View {
        
        let previewDragGesture = DragGesture(minimumDistance: 20)
            .onChanged { value in
                
                if previewHorizontalDragActive {
                    return
                }
                
                if previewCurrentPos == .zero {
                    if abs(value.translation.width) > abs(value.translation.height) {
                        //                    if abs(value.translation.height) < 30 {
                        previewHorizontalDragActive = true
                        return
                        //                    }
                    }
                }
                
                    // VERTICAL ONLY
                    let shouldBePosition = value.translation.height + self.previewNewPos
                    
                    if shouldBePosition < 0 {
                        return
                    } else {
                        self.previewCurrentPos = shouldBePosition
                    }
            }
            .onEnded { value in
                if previewHorizontalDragActive {
                    previewHorizontalDragActive = false
                    return
                }
                
                let shouldBePosition = value.translation.height + self.previewNewPos
                
                if shouldBePosition < 0 {
                    self.previewCurrentPos = .zero
                    self.previewNewPos = .zero
                } else {
                    let closingPoint = screenDims.size.height * 0.2
                    if shouldBePosition > closingPoint {
                        withAnimation {
                            self.showPreviewFullScreen = false
                            self.previewCurrentPos = screenDims.height + 20
                            self.previewNewPos = screenDims.height + 20
                        }
                    }else {
                        withAnimation {
                            self.previewNewPos = .zero
                            self.previewCurrentPos = .zero
                        }
                    }
                }
                previewHorizontalDragActive = false
            }
                
       return ZStack {
            
            TabView {
                HomeView(
                    showPreviewFullScreen: $showPreviewFullScreen,
                    previewStartingIndex: $previewStartingIndex)
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }.tag(0)
                
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }.tag(1)
                
                ComingSoon()
                    .tabItem {
                        Image(systemName: "play.rectangle")
                        Text("Coming Soon")
                    }.tag(2)
                
                DownloadsView()
                    .tabItem {
                        Image(systemName: "arrow.down.to.line.alt")
                        Text("Downloads")
                    }.tag(2)
                
                Text("Menu")
                    .tabItem {
                        Image(systemName: "equal")
                        Text("Menu")
                    }.tag(2)
            }
            .accentColor(.white)
            
            
            PreviewsList(
                movies: exampleMovies,
                currentSelection: $previewStartingIndex,
                isVisible: $showPreviewFullScreen,
                externalDragGesture: previewDragGesture)
            .offset(y: previewCurrentPos)
            .isHidden(!showPreviewFullScreen)
            .animation(.easeIn)
            .transition(.move(edge: .bottom))
            
        }
        .onChange(of: showPreviewFullScreen) { newValue in
            if newValue { //showFullScreen : true
                withAnimation {
                    previewCurrentPos = .zero
                    previewNewPos = .zero
                }
            } else { //hiding
                withAnimation {
                  previewCurrentPos = screenDims.height + 20
                  previewNewPos = screenDims.height + 20
                }
            }
        }
       
        
    }
}

//MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
