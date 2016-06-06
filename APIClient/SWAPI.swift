//
//  SWAPI.swift
//  APIClient
//
//  Created by Christoph Blattgerste on 25.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Moya
import Freddy


//adress of the used API: ("http://swapi.co/api/")

enum SWAPI: Moya.TargetType, Cacheable {
    
    case starships (NamedResource<Starships>)
    case planets (NamedResource<Planets>)
    case species (NamedResource<Species>)
    
    var baseURL: NSURL {return NSURL(string: "http://swapi.co/api")! }
    
    var path : String {
        switch self {
        case .starships(let namedResource): return "/starships/\(namedResource.name)"
        case .planets(let namedResource): return "/planets/\(namedResource.name)"
        case .species(let namedResource): return "/species/\(namedResource.name)"
        }
    }
    
    var method: Moya.Method {return .GET}
    
    var parameters: [String : AnyObject]? {
        switch self {
        default: return nil
        }
    }
    
    var sampleData: NSData {
        switch self {
//        case .starships(let namedResource):
//            return
//            "name": "CR90 corvette",
//            "model": "CR90 corvette",
//            "manufacturer": "Corellian Engineering Corporation",
//            "cost_in_credits": "3500000",
//            "length": "150",
//            "max_atmosphering_speed": "950",
//            "crew": "165",
//            "passengers": "600",
//            "cargo_capacity": "3000000",
//            "consumables": "1 year",
//            "hyperdrive_rating": "2.0",
//            "MGLT": "60",
//            "starship_class": "corvette",
//            "pilots": [],
//            "films": [
//            "http://swapi.co/api/films/6/",
//            "http://swapi.co/api/films/3/",
//            "http://swapi.co/api/films/1/"
//            ],
//            "created": "2014-12-10T14:20:33.369000Z",
//            "edited": "2014-12-22T17:35:45.408368Z",
//            "url": "http://swapi.co/api/starships/2/"
//        .dataUsingEncoding(NSUTF8StringEncoding)!
        default:
            return "".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
    
    var cacheIdentifier: String {
        return self.path
    }
}


struct NamedResource<Resource: Freddy.JSONDecodable>: Freddy.JSONDecodable {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    init(json: JSON) throws {
        self.name = try json.string("name")
    }
    
}