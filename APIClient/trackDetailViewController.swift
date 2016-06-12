//
//  trackDetailViewController.swift
//  APIClient
//
//  Created by Arthur Heimbrecht on 30.5.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit
import Freddy
import Moya


class trackDetailViewController: UIViewController {

	var kanyeAPI: MoyaProvider<kanyeREST>!
	var track: Track!

	@IBOutlet var lyricsLabel: UITextView!
	
	override func viewDidLoad() {
		self.lyricsLabel.text = self.track!.lyrics
		self.lyricsLabel.editable = false
		self.title = self.track!.title + " / " + self.track!.album
	}

}