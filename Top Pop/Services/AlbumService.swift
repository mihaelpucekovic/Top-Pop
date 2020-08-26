//
//  AlbumService.swift
//  Top Pop
//
//  Created by Mihael Puceković on 25/08/2020.
//  Copyright © 2020 Mihael. All rights reserved.
//

import UIKit

class AlbumService {
    func fetchAlbum(albumId: Int, completion: @escaping ((ResultEnum<Any>?) -> Void)){
        let urlString = "https://api.deezer.com/album/\(albumId)"
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        if let albumArray = json as? [String: Any] {
                            let albumId = albumArray["id"] as? Int
                            let albumTitle = albumArray["title"] as? String
                            let albumCover = albumArray["cover"] as? String
                            
                            if let artistArray = albumArray["artist"] as? [String: Any] {
                                let artistId = artistArray["id"] as? Int
                                let artistName = artistArray["name"] as? String
                                let artistPicture = artistArray["picture"] as? String
                                
                                if let tracks = albumArray["tracks"] as? [String: Any],
                                    let tracksData = tracks["data"] as? [[String: Any]] {
                                    var trackNumber = 0
                                    let tracksArray = tracksData.compactMap{ json -> Track? in
                                        if
                                            let id = json["id"] as? Int,
                                            let title = json["title"] as? String,
                                            let duration = json["duration"] as? Int {
                                            
                                            let artist = Artist(id: artistId!, name: artistName!, picture: artistPicture!)
                                            trackNumber += 1
                                                                    
                                            let track = Track(id: id, title: title, duration: duration, artist: artist, trackNumber: "\(trackNumber).", albumId: albumId!)
                                                                    
                                            return track
                                        } else {
                                            return nil
                                        }
                                    }
                                    
                                    let album = Album(id: artistId!, title: albumTitle!, cover: albumCover!, tracks: tracksArray)
                                    
                                    completion(.success(album))
                                } else {
                                    completion(.failure("Failure"))
                                }
                            }
                        } else {
                            completion(.failure("Failure"))
                        }
                    } catch {
                        completion(.failure("Failure"))
                    }
                    
                } else {
                    completion(.failure("Failure"))
                }
            }
            dataTask.resume()
        } else {
            completion(.failure("Failure"))
        }
    }
}
