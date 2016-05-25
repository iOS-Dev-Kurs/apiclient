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

enum SWAPI: Moya.TargetType {
    
    case starship (NamedResource<starship>)
    case planet (NamedResource<planets>)
    case species (NamedResource<species>)
    
    var baseURL: NSURL {return NSURL(string: "http://swapi.co/api/")! }
    
    var path : String {
        switch self {
        case .starship(let namedResource): return "/starships/\(namedResource.name)"
        case .planet(let namedResource): return "/planets/\(namedResource.name)"
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
}