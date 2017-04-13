//
//  APODResult.swift
//  APIClient
//
//  Created by Alex Golovin on 12.04.17.
//  Copyright © 2017 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Freddy

struct APODResult: JSONDecodable {
    
    //let copyright: String
    //let date: String
    //let explanation: String
    //let hdurl: URL
    //let media_type: String
    let title: String
    let url: URL
    
    init(json: JSON) throws {
        try self.url = URL(string:json.getString(at: "url"))!
        try self.title = json.getString(at: "title")
    }
}
