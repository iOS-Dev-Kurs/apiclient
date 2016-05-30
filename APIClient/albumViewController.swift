//
//  albumViewController.swift
//  APIClient
//
//  Created by Arthur Heimbrecht on 30.5.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit
import Freddy
import Moya
/*
class albumViewController: UITableViewController {
	
	/// The Poke API provider that handles requests for server resources
	var kanyeAPI: MoyaProvider<kanyeREST>!
	
	var allalbums: [Album]!
	
	//var albums: [APIResource<kanyeREST, Album>]!
 
	
	// MARK: User Interaction
	
	override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
		switch identifier {
		case "showTracks":
			if let indexPath = tableView.indexPathForSelectedRow, case .loaded = albums[indexPath.row] {
				return true
			} else {
				return false
			}
		default:
			return true
		}
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		switch segue.identifier! {
		case "showTracks":
			guard let trackViewController = segue.destinationViewController as? trackViewController else {
				return
			}
			guard let indexPath = tableView.indexPathForSelectedRow else {
				return
			}
			let selectedAlbum = allalbums[indexPath.row]
			trackViewController.kanyeAPI = kanyeAPI
			trackViewController.trackAlbum = selectedAlbum
		default:
			break
		}
	}
	
}


// MARK: - Table View Datasource

extension albumViewController {
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return allalbums.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		// Load the resource for this row if necessary
		if case .notLoaded(let target) = albums[indexPath.row] {
			albums[indexPath.row] = kanyeAPI.request(target) { result in
				self.albums[indexPath.row] = result
				tableView.reloadRowsAtIndexPaths([ indexPath ], withRowAnimation: .Fade)
			}
		}
		
		// Obtain a cell and configure it
		let cell = tableView.dequeueReusableCellWithIdentifier("albumCell", forIndexPath: indexPath) as! albumCell
		cell.configureForEntry(allalbums[indexPath.row])
		if case .loaded = albums[indexPath.row] {
			cell.selectionStyle = .Default
			cell.accessoryType = .DisclosureIndicator
		} else {
			cell.selectionStyle = .None
			cell.accessoryType = .None
		}
		return cell
	}
	
}
*/