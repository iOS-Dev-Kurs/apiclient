//
//  Wolfram.swift
//  
//
//  Created by Katja D on 12.04.17.
//
//

import Foundation
import Moya

enum Wolframalphaapi: Moya.TargetType {
    
    case shortAnswer(query: String)
    
    var baseURL: URL {
        return URL(string: "http://api.wolframalpha.com/v1")!
    }
    
    var path: String {
        switch self {
        case .shortAnswer(query: let query):
            return "result"
                    }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .shortAnswer(query: let query):
            return [
                "appid": "684X5T-7G57UL5898",
                "i":  query
            ]
            return nil
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
