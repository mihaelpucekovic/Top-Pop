//
//  Album.swift
//  Top Pop
//
//  Created by Mihael Puceković on 24/08/2020.
//  Copyright © 2020 Mihael. All rights reserved.
//

import Foundation

class Album {
    
    let id: Int
    let title: String
    let cover: String
    var tracks = [Track]()
     
    init(id: Int, title: String, cover: String, tracks: [Track]) {
        self.id = id
        self.title = title
        self.cover = cover
        self.tracks = tracks
    }
}
