//
//  Album.swift
//  Top Pop
//
//  Created by Mihael Puceković on 24/08/2020.
//  Copyright © 2020 Mihael. All rights reserved.
//

import Foundation

struct Album: Codable {
    let id: Int
    let title: String
    let cover: String
    let tracks: TracksAlbum
}

struct TracksAlbum: Codable {
    let data: [TrackAlbum]
}

struct TrackAlbum: Codable {
    let id: Int
    let title: String
}
