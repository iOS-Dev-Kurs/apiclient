//
//  album.swift
//  APIClient
//
//  Created by Arthur Heimbrecht on 30.5.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Freddy


struct Album {
	
	let name: String
	let tracks: [Track]
	
	init(tracksfetched: [Track]) throws {
		tracks = tracksfetched
		name = tracksfetched[0].album
	}
}