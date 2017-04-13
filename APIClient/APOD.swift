//
//  APOD.swift
//  APIClient
//
//  Created by Alex Golovin on 12.04.17.
//  Copyright © 2017 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Moya

enum APODapi: Moya.TargetType {
    case apodImage(date: String)
    
    var baseURL: URL {
        return URL(string: "https://api.nasa.gov/planetary")!
    }
    
    var path: String {
        switch self {
        case .apodImage:
            return "apod"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .apodImage(date: let date):
            return [
            "api_key": "ytjs7RGfT3lokh41NHQH914MFWra7PfwaVu2bqXx",
            "date": date,
                ]
            
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Moya.Task {
        return .request
    }
}
