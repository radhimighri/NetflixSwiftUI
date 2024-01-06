//
//  Episode.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 11/09/2023.
//

import Foundation


struct Episode: Identifiable {
    var id = UUID().uuidString
    
    var name: String
    var season: Int
    var episodeNumber: Int
    var thumbnailImageURLString: String
    var description: String
    var length: Int
    
    var videoURL: URL
    
    var thumbnailURL: URL {
        return URL(string: thumbnailImageURLString)!
    }
}
