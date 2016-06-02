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
    
    var baseURL: NSURL {return NSURL(string: "http://swapi.co/api/")! }
    
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
        return "".dataUsingEncoding(NSUTF8StringEncoding)!
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