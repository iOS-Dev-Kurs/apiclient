//
//  trackViewController.swift
//  APIClient
//
//  Created by Arthur Heimbrecht on 30.5.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit
import Freddy
import Moya
/*
class trackViewController: UITableViewController {
	var kanyeAPI: MoyaProvider<kanyeREST>!
	
	var trackAlbum: Album!
	var alltracks: [Track]!

	//var tracks: [APIResource<kanyeREST, Track>]!
	
	// MARK: User Interaction
	
	override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
		switch identifier {
		case "showDetail":
			if let indexPath = tableView.indexPathForSelectedRow, case .loaded = tracks[indexPath.row] {
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
		case "showDetail":
			guard let trackDetailViewController = segue.destinationViewController as? trackDetailViewController else {
				return
			}
			guard let indexPath = tableView.indexPathForSelectedRow else {
				return
			}
			let selectedTrack = tracks[indexPath.row]
			trackDetailViewController.kanyeAPI = kanyeAPI
			trackDetailViewController.track = selectedTrack
		default:
			break
		}
	}
	
}


// MARK: - Table View Datasource

extension trackViewController {
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return alltracks.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		// Load the resource for this row if necessary
		if case .notLoaded(let target) = tracks[indexPath.row] {
			tracks[indexPath.row] = kanyeAPI.request(target) { result in
				self.tracks[indexPath.row] = result
				tableView.reloadRowsAtIndexPaths([ indexPath ], withRowAnimation: .Fade)
			}
		}
		
		// Obtain a cell and configure it
		let cell = tableView.dequeueReusableCellWithIdentifier("trackCell", forIndexPath: indexPath) as! trackCell
		cell.configureForEntry(alltracks[indexPath.row])
		if case .loaded = tracks[indexPath.row] {
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