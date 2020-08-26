//
//  Chart.swift
//  Top Pop
//
//  Created by Mihael Puceković on 26/08/2020.
//  Copyright © 2020 Mihael. All rights reserved.
//

import Foundation

struct Chart: Codable {
    let tracks: Tracks
}

struct Tracks: Codable {
    let data: [Track]
}

struct Track: Codable {
    let id: Int
    let title: String
    let duration: Int
    let artist: Artist
    let album: AlbumChart
}

struct Artist: Codable {
    let id: Int
    let name: String
    let picture: String
}

struct AlbumChart: Codable {
    let id: Int
    let cover: String
}
