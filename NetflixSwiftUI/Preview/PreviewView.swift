//
//  PreviewView.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 18/09/2023.
//

import SwiftUI

struct PreviewView: View {
    //MARK: - Properties && Helpers
    @ObservedObject var vm: PreviewVM
    
    var playVideo: Bool
    
    //MARK: - View
    var body: some View {
        
        print("DEBUG::: vm.movie.trailers.first?.videoURL \(vm.movie.trailers.first?.videoURL)")
       return ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            TrailerPlayerView(
                videoURL: vm.movie.trailers.first?.videoURL,
                playVideo: .constant(playVideo))
            
            VStack {
                HStack {
                    VStack(alignment: .leading,spacing: 0) {
                        Text(vm.movie.name)
                            .foregroundColor(vm.movie.accentColor)
                            .bold()
                            .font(.largeTitle)
                    }
                    
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.top, 60)
                
                Spacer()
                
                
                HStack {
                    ForEach(0..<vm.movie.categories.count) { catIndex in
                        let category = vm.movie.categories[catIndex]
                        
                        HStack {
                            Text(category)
                                .font(.footnote)
                            
                            // !vm.isCategoryLast(category) ?
                            //                                Image(systemName: "circle.fill")
                            //                                    .font(.system(size: 3))
                            //                                : nil
                            // or:
                            if catIndex != vm.movie.categories.count - 1 {
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 3))
                            }
                            
                        }
                    }
                }
                
                HStack {
                    Spacer()
                    SmallVerticalButton(
                        text: "My List",
                        isOnImage: "checkmark",
                        isOffImage: "plus",
                        color: vm.movie.accentColor,
                        isOn: true) {
                        }
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        HStack {
                            Image(systemName: "arrowtriangle.right.fill")
                            Text("PLAY")
                                .fontWeight(.heavy)
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 26)
                        .border(vm.movie.accentColor, width: 3)
                    })
                    
                    Spacer ()
                    
                    SmallVerticalButton(
                        text: "Info",
                        isOnImage: "info.circle",
                        isOffImage: "info.circle",
                        color: vm.movie.accentColor,
                        isOn: true) {
                            //
                        }
                    
                    Spacer ()
                }
                .padding(.vertical, 14)
                
            }
            .padding(.bottom, 48)
            .foregroundColor(vm.movie.accentColor)
        }
        .edgesIgnoringSafeArea(.vertical)
    }
}


//MARK: - Previews
struct PreviewView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView(vm: PreviewVM(movie: exampleMovie1), playVideo: true)
    }
}
