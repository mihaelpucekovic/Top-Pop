//
//  TracksViewController.swift
//  Top Pop
//
//  Created by Mihael Puceković on 24/08/2020.
//  Copyright © 2020 Mihael. All rights reserved.
//

import UIKit

class TracksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortButton: UIButton!
    
    var refreshControl: UIRefreshControl!
    var track: Track?
    var tracksArrayFetched = [Track]()
    var tracksArray = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TracksViewController.refreshTracks), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        
        tableView.register(UINib(nibName: "TrackTableViewCell", bundle: nil), forCellReuseIdentifier: "trackCellReuseIdentifier")
        
        fetchTracksFromServer()
    }
    
    func fetchTracksFromServer() {
        TrackService().fetchTracks() { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let tracks as [Track]):
                    self!.showFetchedTracks(tracksServer: tracks)
                case .failure( _):
                    let alert = UIAlertController(title: "Error", message: "Error while feetching tracks from the server.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                        self!.fetchTracksFromServer()
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
    
    func showFetchedTracks(tracksServer: [Track]) {
        tracksArrayFetched = tracksServer
        tracksArray = tracksArrayFetched
        
        refreshTable()
    }
    
    func refreshTable() {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    @objc func refreshTracks() {
        fetchTracksFromServer()
    }
    
    func sort(sortType: String) {
        if (sortType == "normal") {
            tracksArray = tracksArrayFetched
            navigationItem.title = "Top 10"
        }
        else if (sortType == "sort asc") {
            tracksArray = tracksArrayFetched.sorted(by: { $0.duration < $1.duration })
            navigationItem.title = "Top 10 asc"
        }
        else if (sortType == "sort desc") {
            tracksArray = tracksArrayFetched.sorted(by: { $0.duration > $1.duration })
            navigationItem.title = "Top 10 desc"
        }
        
        refreshTable()
    }
    
    @IBAction func clickedSort(_ sender: UIButton) {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let firstAction: UIAlertAction = UIAlertAction(title: "normal", style: .default) { action -> Void in
            self.tracksArray = self.tracksArrayFetched
            self.navigationItem.title = "Top 10"
            self.refreshTable()
        }

        let secondAction: UIAlertAction = UIAlertAction(title: "sort asc", style: .default) { action -> Void in
            self.tracksArray = self.tracksArrayFetched.sorted(by: { $0.duration < $1.duration })
            self.navigationItem.title = "Top 10 asc"
            self.refreshTable()
        }

        let thirdAction: UIAlertAction = UIAlertAction(title: "sort desc", style: .default) { action -> Void in
            self.tracksArray = self.tracksArrayFetched.sorted(by: { $0.duration > $1.duration })
            self.navigationItem.title = "Top 10 desc"
            self.refreshTable()
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }

        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(thirdAction)
        actionSheetController.addAction(cancelAction)

        actionSheetController.popoverPresentationController?.sourceView = sortButton

        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCellReuseIdentifier", for: indexPath) as! TrackTableViewCell
        
        track = tracksArray[indexPath.row]
        cell.setup(withTrack: track!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        track = tracksArray[indexPath.row]
        performSegue(withIdentifier: "segueAlbum", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueAlbum" {
            let albumViewController = segue.destination as! AlbumViewController
            
            albumViewController.track = track
        }
    }
}
