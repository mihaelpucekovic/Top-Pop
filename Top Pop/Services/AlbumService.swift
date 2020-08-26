//
//  AlbumServiceNew.swift
//  Top Pop
//
//  Created by Mihael Puceković on 26/08/2020.
//  Copyright © 2020 Mihael. All rights reserved.
//

import UIKit

class AlbumService {
    func fetchAlbum(albumId: Int, completion: @escaping ((ResultEnum<Any>?) -> Void)){
        let urlString = "https://api.deezer.com/album/\(albumId)"
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let jsonData = data {
                    let decoder = JSONDecoder()
                
                    if let album = try? decoder.decode(Album.self, from: jsonData) {
                        completion(.success(album))
                    }
                    else {
                        completion(.failure("Failure"))
                    }
                }
            }
            dataTask.resume()
        }
        else {
            completion(.failure("Failure"))
        }
    }
}
