//
//  ForecastAPI.swift
//  APIClient
//
//  Created by Colin Otchere on 06.06.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Moya
import Freddy

enum ForecastAPI: Moya.TargetType,Cacheable{
    
    // MARK: Network Abstraction status
    
    case cityWeather(coordinate: Coordinate)
    
    var baseURL: NSURL { return NSURL(string: "https://api.forecast.io")! }
    
    var path: String {
        switch self {
        case .cityWeather(coordinate: let coordinate):
            print("https://api.forecast.io/forecast/9aa042dabcaa8424727f3a49b9cff386/\(coordinate.commaSeparatedDescription)")
            return "/forecast/9aa042dabcaa8424727f3a49b9cff386/\(coordinate.commaSeparatedDescription)"
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
        default: return "".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
    
    var cacheIdentifier: String {
        return self.path
    }
}

/// Represents a resource provided by the ForecastAPI by its name
struct Coordinate: Freddy.JSONDecodable {
    
    let latRes: Double
    let lngRes: Double
    
    init(lat: Double,lng: Double) {
        self.latRes = lat
        self.lngRes = lng
    }
    
    var commaSeparatedDescription: String {
        return String(self.latRes) + "," + String(self.lngRes)
    }
    
    init(json: JSON) throws {
        self.latRes = try json.double("latitude")
        self.lngRes = try json.double("longitude")
    }
    
}
