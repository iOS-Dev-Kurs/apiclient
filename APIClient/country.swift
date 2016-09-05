//
//  country.swift
//  APIClient
//
//  Created by Lucas Moeller on 22.08.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Freddy
import UIKit

public struct Country {
    
    let name: String
    let languages: [JSON]
    let population: Int
    let capital: String
}

extension Country: JSONDecodable {
    public init(json: JSON) throws {
        name = try json.string("name")
        languages = try json.array("languages")
        population = try json.int("population")
        capital = try json.string("capital")
    }
}