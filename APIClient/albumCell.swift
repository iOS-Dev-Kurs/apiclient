//
//  AlbumCell.swift
//  APIClient
//
//  Created by Arthur Heimbrecht on 30.5.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//
import Foundation

import UIKit

class albumCell: UITableViewCell {
	func configurewithalbum(album: Album) {
		textLabel?.text = album.name
	}
	func configurewithstring(title: String) {
		textLabel?.text = title
	}
}