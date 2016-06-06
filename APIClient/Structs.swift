//
//  Structs.swift
//  APIClient
//
//  Created by Christoph Blattgerste on 30.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Freddy
import UIKit

struct Starships: JSONDecodable {
    
    let name : String
    
    let starshipClass : String
    
    let costInCredits : String
    
    init (json: JSON) throws {
        self.name = try json.string("name")
        self.costInCredits = try json.string("cost_in_credits")
        self.starshipClass = try json.string("starship_class")
    }
}

struct Planets: JSONDecodable {
    
    let name : String
    let population : String
    let terrain : String
    
    init(json: JSON) throws {
        self.name = try json.string("name")
        self.population = try json.string("population")
        self.terrain = try json.string("terrain")
    }
}

struct Species: JSONDecodable {
    
    let name : String
    let homeworld : String
    let language : String
    
    init(json: JSON) throws {
        self.name = try json.string("name")
        self.language = try json.string("language")
        self.homeworld = try json.string("homeworld")
    }
    
}
