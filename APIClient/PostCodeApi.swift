//
//  PostCodeApi.swift
//  Pods
//
//  Created by Florian M. on 04/06/16.
//
//

import Foundation
import Freddy
import Moya


enum Zippopotam: Moya.TargetType {
    
    /// MARK: Endpoints
    
    
    case germany(postalCode: String)
    
    
    var baseURL: NSURL { return NSURL (string: "http://api.zippopotam.us")! }
    var path: String {
        switch self {
            case .germany(postalCode: let a): return "/DE/"+a
        }
    }
    var method: Moya.Method { return .GET }
    var parameters: [String : AnyObject]? {
        return nil
    }
    var sampleData: NSData {return "{\"post code\": \"90210\",\"country\": \"United States\",\"country abbreviation\": \"US\",\"places\": [\"place name\": \"Beverly Hills\",\"longitude\": \"-118.4065\",\"state\": \"California\",\"state abbreviation\": \"CA\", \"latitude\": \"34.0901\"]}".dataUsingEncoding(NSUTF8StringEncoding)!}
            
            

}

struct PlaceInfo{
    let placeName: String
    let placeLongitude: String
    let placeLatitude: String
    public init(json: JSON) throws {
        self.placeName = try json.array("places")[0].string("place name")
        self.placeLongitude = try json.array("places")[0].string("longitude")
        self.placeLatitude = try json.array("places")[0].string("latitude")
    }
}