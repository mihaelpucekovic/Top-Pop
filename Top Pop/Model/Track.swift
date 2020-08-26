//
//  Track.swift
//  Top Pop
//
//  Created by Mihael Puceković on 24/08/2020.
//  Copyright © 2020 Mihael. All rights reserved.
//

import Foundation

class Track {
    
    let id: Int
    let title: String
    let duration: Int
    let artist: Artist
    let trackNumber: String
    let albumId: Int
     
    init(id: Int, title: String, duration: Int, artist: Artist, trackNumber: String, albumId: Int) {
        self.id = id
        self.title = title
        self.duration = duration
        self.artist = artist
        self.trackNumber = trackNumber
        self.albumId = albumId
    }
}
