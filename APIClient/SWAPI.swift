//
//  SWAPI.swift
//  APIClient
//
//  Created by logosal mac on 06.06.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Moya
import Freddy


enum SWAPI: Moya.TargetType, Cacheable {

    case people(id: Int)
    
    var baseURL: NSURL { return NSURL(string: "http://swapi.co/api")! }
    
    var path: String {
        switch self {
        case .people(let id): return "/people/:\(id)/"
        }
    }
    
    var method: Moya.Method { return .GET }
    
    var parameters: [String : AnyObject]? {
        switch self {
        default: return nil
        }
    }
    
    var sampleData: NSData {
        switch self {
        default: return "".dataUsingEncoding(NSUTF8StringEncoding)!
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
