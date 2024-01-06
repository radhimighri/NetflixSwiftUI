//
//  Trailer.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 12/09/2023.
//

import Foundation


struct Trailer: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var name: String
    var videoURL: URL
    var thumbnailImageURL: URL
}
