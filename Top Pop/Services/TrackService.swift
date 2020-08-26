//
//  TrackService.swift
//  Top Pop
//
//  Created by Mihael Puceković on 24/08/2020.
//  Copyright © 2020 Mihael. All rights reserved.
//

import UIKit

class TrackService {
    func fetchTracks(completion: @escaping ((ResultEnum<Any>?) -> Void)){
        let urlString = "https://api.deezer.com/chart"
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let jsonData = data {
                    let decoder = JSONDecoder()
                
                    if let chart = try? decoder.decode(Chart.self, from: jsonData) {
                        completion(.success(chart))
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
