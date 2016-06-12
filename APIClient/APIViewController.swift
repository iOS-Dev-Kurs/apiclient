//
//  APIViewController.swift
//  kanyeAPIClient
//
//  Created by Arthur Heimbrecht on 30.5.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import UIKit
import Freddy
import Moya

class APIViewController: UIViewController {
	
	var kanyeAPI: MoyaProvider<kanyeREST>!
	var target = kanyeREST.track(title: "good_morning")
	var fetchedtrack: Track!
	
	var allalbums: [Album] = []
	var allalbumnames: [String]!
	
	@IBOutlet private var lyricsLabel: UILabel!
	
	override func viewDidLoad() {
		print("didload")
		kanyeAPI.request(target){
			result in
			switch result {
			case .Success(let response):
				do {
					try response.filterSuccessfulStatusCodes()
					print(response)
					let json = try JSON(data: response.data)
					self.fetchedtrack = try Track(json: json)
					self.lyricsLabel.numberOfLines = 0
					self.lyricsLabel.text = self.fetchedtrack.lyrics
					let tracknalbum = self.fetchedtrack.title + " / " + self.fetchedtrack.album
					self.title = tracknalbum
				} catch {
					print(error)
				}
			case .Failure(let error):
				print(error)
			}
		}
		
		for albumname in allalbumnames{
			kanyeAPI.request(kanyeREST.album(title: albumname)){
				result in
				//print(title)
				switch result {
				case .Success(let response):
					do {
						try response.filterSuccessfulStatusCodes()
						print(response)
						let json = try JSON(data: response.data)
						let tracks = try json.array("result").map(Track.init)
						self.allalbums.append(try Album(tracksfetched: tracks))
						print(self.allalbums[0])
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
		
	}
}