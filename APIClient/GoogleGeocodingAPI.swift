//
//  WeatherApi.swift
//  APIClient
//
//  Created by Colin Otchere on 05.06.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Moya
import Freddy

enum GoogleGeocodingAPI: Moya.TargetType,Cacheable{
    
    // MARK: Network Abstraction status
    
    case cityRawData(CityResource<CityRawData>)
    
    var baseURL: NSURL { return NSURL(string: "https://maps.googleapis.com/maps/api")! }
    
    var path: String {
        switch self {
        case .cityRawData: return "/geocode/json"
        }
    }
    
    var method: Moya.Method { return .GET }
    
    var parameters: [String : AnyObject]? {
        switch self {
        case .cityRawData(let namedResource):
            return [
                "address": namedResource.name,
                "components": "country:DE",
                //"key": "AIzaSyBWzX1_Pzrxyf04oADXfHxqHIEkvAHdTAo",
            ]
        }
    }
    
    // TODO: Provide sample data for testing
    var sampleData: NSData {
        switch self {
        default: return "".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
    
    var cacheIdentifier: String {
        return self.path
    }
}

/// Represents a resource provided by the GoogleGeocodingAPI by its name
struct CityResource<Resource: Freddy.JSONDecodable>: Freddy.JSONDecodable {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    init(json: JSON) throws {
        self.name = try json.string("")
    }
    
}



