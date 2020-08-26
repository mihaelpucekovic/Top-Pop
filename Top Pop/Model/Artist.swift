//
//  Artist.swift
//  Top Pop
//
//  Created by Mihael Puceković on 24/08/2020.
//  Copyright © 2020 Mihael. All rights reserved.
//

import Foundation

class Artist {
    
    let id: Int
    let name: String
    let picture: String
     
    init(id: Int, name: String, picture: String) {
        self.id = id
        self.name = name
        self.picture = picture
    }
}
