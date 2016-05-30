//
//  PlanetAPI.swift
//  APIClient
//
//  Created by Kleimaier, Dennis on 23.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Moya
import Freddy

enum PlanetAPI: Moya.TargetType{
    case planet(NamedResource<Planet>)
    
    var baseURL: NSURL { return NSURL(string: "http://swapi.co/api")! }
    
    var path: String {
        switch self{
        case .planet(let namedResource): return "/planets/\(namedResource.name)"
        }
    }
    
    var method: Moya.Method { return .GET }
    
    var parameters: [String : AnyObject]? {
        switch self {
        default: return nil
        }
    }
    
    // TODO: Provide sample data for testing
    var sampleData: NSData {
        switch self {
<<<<<<< HEAD
        case .planet(let namedResource): return "{\"planets\": \"\(namedResource.name)\",\"planets\":\"Tatooine\"}".dataUsingEncoding(NSUTF8StringEncoding)!
=======
>>>>>>> 20509778bf722e35f883d2251b936b6b4841a715
        default: return "".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
}

struct NamedResource<Resource: Freddy.JSONDecodable>: Freddy.JSONDecodable {
    
    let name:String
    
    init(name: String) {
        self.name = name
    }
    
    init(json: JSON) throws {
        self.name = try json.string("name")
    }
}