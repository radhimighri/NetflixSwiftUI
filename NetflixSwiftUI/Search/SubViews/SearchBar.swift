//
//  SearchBar.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 17/09/2023.
//

import SwiftUI

struct SearchBar: View {
    //MARK: - Properties
    @Binding var text: String
    
    @State private var isEditing = true
    
    @Binding var isLoading: Bool
    
    
    //MARK: - View
    var body: some View {
        print("DEBUG::: is loading : \(isLoading)")
        return ZStack(alignment: .leading) {
            Color.graySearchBackground
                .frame(width: 270, height: 36)
                .cornerRadius(8)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.graySearchText)
                    .padding(.leading, 10)
                
                TextField("Search", text: $text)
                    .padding(7)
                    .padding(.leading, -7)
                    .padding(.horizontal, 10)
                    .background(Color.graySearchBackground)
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .onTapGesture {
                        isEditing = true
                    }
                    .animation(.default)
 
            
                if !text.isEmpty {
                    if isLoading {
                       
                         Button {
                            text = ""
                            isEditing = false
                         } label: {
                            ActivityIndicator(style: .medium, animate: .constant(true))
                                .configure {
                                    $0.color = .white
                                }
                            
                        }
                        .padding(.trailing, 32)
                        .frame(width: 35, height: 35)
                        
                    } else {
                        Button {
                            text = ""
                            isEditing = false
                         } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.graySearchText)
                                .frame(width: 35, height: 35)
                        }
                        .padding(.trailing, 18)
                    }
                }
                
                if isEditing {
                    Button {
                        text = ""
                        isEditing = false
                        hidekeyboard()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.white)
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)

                }
            }
        }
        
    }
}


//MARK: - Previews
struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            SearchBar(text: .constant("test"), isLoading: .constant(false))
                .padding()
        }
    }
}
