//
//  PreviewsList.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 18/09/2023.
//

import SwiftUI

struct PreviewsList: View {
    //MARK: - Properties
    var movies: [Movie]
    
    @Binding var currentSelection: Int
    @Binding var isVisible: Bool
    
    @State private var currentTranslation: CGFloat = 0
    
    let externalDragGesture: _EndedGesture<_ChangedGesture<DragGesture>>
    
    let scrinDims = UIScreen.main.bounds
    
    func shouldPlayVideo(index: Int) -> Bool { ///ensure that w're playing only 1 video
        if !isVisible {
            return false
        }
        if index != currentSelection {
            return false
        }
        return true
    }
    //MARK: - View
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            PagerView(
                pageCount: movies.count,
                currentIndex: $currentSelection,
                translation: $currentTranslation,
                externalDragGesture: externalDragGesture) {
                    
                    ForEach(0..<movies.count) { movieIndex in
                        let movie = movies[movieIndex]
                        
                        PreviewView(
                            vm: PreviewVM(movie: movie),
                    playVideo: shouldPlayVideo(index: movieIndex)
                    )
                        .frame(width: scrinDims.width)
                }
            }
                      .frame(width: scrinDims.width)
        }
    }
}


////MARK: - ExamplePreviewList
//struct ExamplePreviewList: View {
//    @State private var currentSelection = 0
//    @State private var isVisible = true
//    var body: some View {
//        PreviewsList(
//            movies: exampleMovies,
//            currentSelection: $currentSelection,
//            isVisible: $isVisible,
//            externalDragGesture: externalDragGesture
//        )
//    }
//}
//
////MARK: - Previews
//struct PreviewsList_Previews: PreviewProvider {
//    static var previews: some View {
//        ExamplePreviewList()
////        PreviewsList(
////            movies: exampleMovies,
////            currentSelection: .constant(0),
////            isVisible: .constant(true)
////        )
//    }
//}
