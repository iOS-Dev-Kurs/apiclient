//
//  quotes.swift
//  APIClient
//
//  Created by Elvira  Beisel on 12.04.17.
//  Copyright © 2017 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Moya

enum Quotesapi: Moya.TargetType {
    
    case quote(category: String)
    
    var baseURL: URL {
        return URL(string: "https://andruxnet-random-famous-quotes.p.mashape.com/")!
    }

    var path: String {
        
        switch self {
        case .quote:
            return ""
        }
    }
    
    var method: Moya.Method {
        return.get
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .quote(category: let category):
            return [
                "cat": category 
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
