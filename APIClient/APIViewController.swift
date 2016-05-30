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
		
	}
}