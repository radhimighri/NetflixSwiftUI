//
//  PagerView.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 18/09/2023.
//

import SwiftUI

struct PagerView<Content: View>: View { //it takes a generic content (View)
    
    //MARK: - Properties && Helpers
    let pageCount: Int
    @Binding var currentIndex: Int
    @Binding var translation: CGFloat
    
    @State private var verticalDragIsActive = false
    
    let externalDragGesture: _EndedGesture<_ChangedGesture<DragGesture>>
    
    let content: Content
    
    
    /// Custom initializer
    init(
        pageCount: Int,
        currentIndex: Binding<Int>,
        translation: Binding<CGFloat>,
        externalDragGesture: _EndedGesture<_ChangedGesture<DragGesture>>,
        @ViewBuilder content: () -> Content
    ) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self._translation = translation
        self.externalDragGesture = externalDragGesture
        self.content = content()
    }
    
    //MARK: - View
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                self.content
                    .frame(width: geo.size.width)
            }
            .frame(width: geo.size.width, alignment: .leading)
            .offset(x: -CGFloat(self.currentIndex) * geo.size.width) //once we swipe till the end and let go
            .offset(x: self.translation) //as we dragging
            .animation(.interactiveSpring())
//            .gesture(
//                DragGesture()
//                    .onChanged({ value in
//                        self.translation = value.translation.width //we care only for  horizontal value (left/right swipe)
//                    })
//                    .onEnded({ value in
//                        let offset = value.translation.width / geo.size.width
//                        let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
//                        currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1) //set the new currentIndex value while preventing negative and limit overflow
            //                        translation = 0
            //                    })
            //            )
            .gesture(
                externalDragGesture.simultaneously(
                    with:
                        DragGesture(minimumDistance: 20)
                        .onChanged({ value in
                            if verticalDragIsActive {
                                return
                            }
                            
                            if abs(value.translation.width) < abs(value.translation.height) {
                                verticalDragIsActive = true
                                return
                            }
                            
                                //Horizontal Drag only
                             translation = value.translation.width //we care only for  horizontal value (left/right swipe)
                        })
                        .onEnded({ value in
                            if verticalDragIsActive {
                                verticalDragIsActive = false
                                return
                            }
                            
                            //Ending a horizontal Drag here
                            let offset = value.translation.width / geo.size.width
                            let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                            currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1) //set the new currentIndex value while preventing negative and limit overflow
                            translation = 0
                        })
                )
            )
        }
    }
}



//MARK: - Dummy View
//struct PagerDummyView: View {
//    @State private var currentIndex: Int = 0
//    @State private var translation: CGFloat = .zero
//    
//      var body: some View {
//        
//        PagerView(
//            pageCount: 3,
//            currentIndex: $currentIndex,
//            translation: $translation) {
//            Color.red
//            Color.green
//            Color.blue
//        }
//    }
//}
//
////MARK: - Previews
//struct PagerView_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        
//        PagerDummyView()
//        
////        PagerView(pageCount: 3, currentIndex: .constant(1), translation: .constant(.zero), content: {
////            Color.red
////            Color.green
////            Color.blue
////        })
//    }
//}
