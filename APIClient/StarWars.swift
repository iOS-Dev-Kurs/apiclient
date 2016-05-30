//
//  StarWars.swift
//  APIClient
//
//  Created by Felix Meissner on 5/29/16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Freddy
import UIKit

struct SWPlanet: JSONDecodable {
    
    /// The name of the resource, such as "Tatooine"
    let name: String
    let diameter: String
    let rotation_period: String
    let orbital_period: String
    let gravity: String
    


    
    init(json: JSON) throws {
        self.name = try json.string("name")
        self.diameter = try json.string("diameter")
        self.rotation_period = try json.string("rotation_period")
        self.orbital_period = try json.string("orbital_period")
        self.gravity = try json.string("gravity")
    }
    
}