//
//  City.swift
//  APIClient
//
//  Created by Colin Otchere on 06.06.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Moya
import Freddy

struct CityRawData: JSONDecodable{
    
    
    let status: String
    let result: [CityDetail]
 
    init(json: JSON) throws {
        self.status = try json.string("status")
        self.result = try json.arrayOf("results")
    }
    
    struct CityDetail:JSONDecodable {
        let formatedAdress: String
        let geometry: Geometry
        init(json: JSON) throws {
            self.formatedAdress = try json.string("formatted_address")
            self.geometry = try json.decode("geometry")
        }
    }
}

struct Geometry: JSONDecodable{
    
    let location: Coordination
    init(json: JSON) throws {
        self.location = try json.decode("location")
    }
}

struct Coordination: JSONDecodable{
    
    let lat: Double
    let lng: Double
    
    init(json: JSON) throws {
        self.lat = try json.double("lat")
        self.lng = try json.double("lng")
    }
}