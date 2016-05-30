//SWAPI
//  APIClient

import Foundation
import Moya
import Freddy



/// The abstraction of the [SWAPI](http://swapi.co) REST API.
enum SWAPI: Moya.TargetType {
    
    
    /// MARK: Endpoints
    
    case planets (NamedResource<SWPlanet>)
    case planets_id (NamedResource<SWPlanet>)
    case planets_schema (NamedResource<SWPlanet>)
    
    
    // MARK: Network Abstraction
    
    var baseURL: NSURL { return NSURL(string: "http://swapi.co/api")! }
    
    var path: String {
        switch self {
        case .planets(let namedResource): return "/planets/\(namedResource.name)"
        case .planets_id(let namedResource): return "/planets_id/\(namedResource)"
        case .planets_schema(let namedResource): return "/planets_schema/\(namedResource)"
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









