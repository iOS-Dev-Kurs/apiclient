//
//  album.swift
//  APIClient
//
//  Created by Arthur Heimbrecht on 30.5.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Freddy

/*
/// A Pokedex contains the Pokemon species encountered in a specific region of the Pokemon world
struct Album: JSONDecodable {
	
	let name: String
	let tracks: [track]
	
	struct track: JSONDecodable {
		
		//		let track: NamedResource<Track>
		
		init(json: JSON) throws {
			self.track = try json.decode("title")
		}
	}
	
	init(json: JSON) throws {
		self.name = try json.string("album")
		self.tracks = try json.arrayOf("title") //write func
	}
	
	init(title: String){
		self.name = title
		self.tracks = try json.arrayOf("title")
	}
	
}
*/