//
//  track.swift
//  APIClient
//
//  Created by Arthur Heimbrecht on 30.5.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Freddy

/// A specific Pokemon variety of a species
struct Track: JSONDecodable {
	
	/// The visual depictions of this Pokemon
	let title: String
	let lyrics: String
	let album: String
	
	init(json: JSON) throws {
		self.title = try json.decode("title")
		self.lyrics = try json.decode("lyrics")
		self.album = try json.decode("album")
	}
	
}