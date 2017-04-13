//
//  results.swift
//  APIClient
//
//  Created by Elvira  Beisel on 12.04.17.
//  Copyright © 2017 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Freddy

struct results: JSONDecodable {
    
    let quote: String
    let author: String
    let category: String
    
    init(json: JSON) throws {
        try self.quote = json.getString(at: "quote")
        try self.author = json.getString(at: "author")
        try self.category = json.getString(at: "category")
        
    }
    
}
