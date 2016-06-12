//
//  trackCell.swift
//  APIClient
//
//  Created by Arthur Heimbrecht on 30.5.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//
import Foundation

import UIKit
import Freddy
import Moya

class trackCell: UITableViewCell {
	func configureForEntry(track: Track) {
		textLabel?.text = track.title
	}
}