//
//  TrackTableViewCell.swift
//  Top Pop
//
//  Created by Mihael Puceković on 25/08/2020.
//  Copyright © 2020 Mihael. All rights reserved.
//

import UIKit
import Kingfisher

class TrackTableViewCell: UITableViewCell {

    @IBOutlet weak var trackNumber: UILabel!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var trackDuration: UILabel!
    @IBOutlet weak var albumCover: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNumber.text = ""
        trackName.text = ""
        artistName.text = ""
        trackDuration.text = ""
    }
    
    func setup(withTrack track: Track, number: String) {
        let url = URL(string: track.album.cover)
        albumCover.kf.setImage(with: url)
        
        trackNumber.text = number
        trackName.text = track.title
        artistName.text = track.artist.name
        
        let minutes = track.duration / 60
        let seconds = track.duration % 60
        trackDuration.text = String(format:"%d:%02d", minutes, seconds)
    }
}
