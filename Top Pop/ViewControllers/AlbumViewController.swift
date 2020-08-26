//
//  AlbumViewController.swift
//  Top Pop
//
//  Created by Mihael Puceković on 25/08/2020.
//  Copyright © 2020 Mihael. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {
    
    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var tracksLabel: UILabel!
    @IBOutlet weak var albumTracks: UILabel!
    
    var track: Track?
    var album: Album?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trackName.text = track?.title
        artistName.text = track?.artist.name
        
        fetchAlbumFromServer()
    }
    
    func fetchAlbumFromServer() {
        AlbumService().fetchAlbum(albumId: track!.albumId) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedAlbum as Album):
                    self!.showAlbum(fetchedAlbum: fetchedAlbum)
                case .failure( _):
                    let alert = UIAlertController(title: "Error", message: "Error while feetching tracks from the server.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                        self!.fetchAlbumFromServer()
                    }))
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: nil))
                    self!.present(alert, animated: true, completion: nil)
                case .none:
                    break
                case .some(.success(_)):
                    break
                }
            }
        }
    }
    
    func showAlbum(fetchedAlbum: Album) {
        album = fetchedAlbum
        
        let urlString = URL(string: album!.cover)
        let imageData = try? Data(contentsOf: urlString!)
        albumCover.image = UIImage(data: imageData!)
        
        albumTitle.text = "Album: \(album!.title)"
        
        var tracks = ""
        
        for track in album!.tracks {
            if tracks == "" {
                tracks = track.title
            }
            else {
                tracks = "\(tracks)\n\(track.title)"
            }
        }
        albumTracks.text = tracks
        
        albumTitle.isHidden = false
        tracksLabel.isHidden = false
        albumTracks.isHidden = false
    }
}
