//
//  Planet.swift
//  APIClient
//
//  Created by Kleimaier, Dennis on 23.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Freddy

struct Planet: JSONDecodable {
    
    let name: String
    
    init(json: JSON) throws {
        self.name = try json.string("name")
    }
    
}