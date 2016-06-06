//
//  Peoples.swift
//  APIClient
//
//  Created by logosal mac on 06.06.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Freddy
import UIKit

// Informationen über Figur

struct SWPeoples: JSONDecodable {

    let name: String
    let gender: String
    let height: String
    let mass: String
    

 // Durchsucht Datei von API nach Schlagwörtern
    
    init(json: JSON) throws {
        self.name = try json.string("name")
        self.gender = try json.string("gender")
        self.height = try json.string("height")
        self.mass = try json.string("mass")
        
    }

}
