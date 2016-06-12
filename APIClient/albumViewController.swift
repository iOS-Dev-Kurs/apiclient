//
//  albumViewController.swift
//  APIClient
//
//  Created by Arthur Heimbrecht on 30.5.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import UIKit
import Freddy
import Moya

class albumViewController: UITableViewController {
	
	/// The Poke API provider that handles requests for server resources
	var kanyeAPI: MoyaProvider<kanyeREST>!
	var allalbums: [Album] = []
	var allalbumnames: [String]?
	
	//var albums: [APIResource<kanyeREST, Album>]!
 
	override func viewDidLoad() {
		//super.viewDidLoad()
		print("VC loaded")
		self.title = "Kanye = God"
		for albumname in self.allalbumnames!{
			kanyeAPI.request(kanyeREST.album(title: albumname)){
				result in
				//print(title)
				switch result {
				case .Success(let response):
					do {
						try response.filterSuccessfulStatusCodes()
						//print(response)
						let json = try JSON(data: response.data)
						let tracks = try json.array("result").map(Track.init)
						print(tracks)
						self.allalbums.append(try Album(tracksfetched: tracks))
						//print(self.allalbums[0])
						print(self.allalbums)
					} catch {
						print(error)
						break
					}
				case .Failure(let error):
					print("failure")
					print(error)
					break
				}
			}
		}

		
		print("didload")
	}
	
	// MARK: User Interaction
	
	/*override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
		switch identifier {
		case "showTracks":
			if let indexPath = tableView.indexPathForSelectedRow, case .loaded = allalbums[indexPath.row] {
				return true
			} else {
				return false
			}
		default:
			return true
		}
	}*/
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		switch segue.identifier! {
		case "showTracks":
			print("selected")
			guard let trackViewController = segue.destinationViewController as? trackViewController else {
				return
			}
			guard let indexPath = tableView.indexPathForSelectedRow else {
				return
			}
			let selectedAlbum = allalbums[indexPath.row]
			trackViewController.kanyeAPI = kanyeAPI
			trackViewController.trackAlbum = selectedAlbum
			trackViewController.alltracks = selectedAlbum.tracks
		default:
			break
		}
	}
	
}


// MARK: - Table View Datasource

extension albumViewController {
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {return 1}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print(self.allalbumnames!.count)
		return self.allalbumnames!.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		// Obtain a cell and configure it
		let cell = tableView.dequeueReusableCellWithIdentifier("albumCell", forIndexPath: indexPath) as! albumCell
		let albumname = self.allalbumnames![indexPath.row]
		cell.configurewithstring(albumname)
		return cell
	}
	
}
