//
//  countryAPI.swift
//  APIClient
//
//  Created by Lucas Moeller on 22.08.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Moya
import Freddy

enum countryAPI: Moya.TargetType, Cacheable {
    
    case fullName(name: String)
    
    var baseURL: NSURL {return NSURL(string: "https://restcountries.eu/rest/v1")!}
        
    var path: String {
        switch self {
        case .fullName(let countryName): return "/name/\(countryName)" //fullText=true
        }
    }
    
    var method: Moya.Method {
        return .GET
    }
    
    var parameters: [String : AnyObject]? {return nil}
    
    var sampleData: NSData {
        switch self {
        case .fullName(let countryName): return "[{\"name\": \(countryName),\"capital\": \"Paris\",\"altSpellings\": [\"FR\",\"French Republic\",\"République française\"],\"relevance\": \"2.5\",\"region\": \"Europe\",\"subregion\": \"Western Europe\",\"translations\": {\"de\": \"Frankreich\",\"es\": \"Francia\",\"fr\": \"France\",\"ja\": \"フランス\",\"it\": \"Francia\"},\"population\": 66186000,\"latlng\": [46,2],\"demonym\": \"French\",\"area\": 640679,\"gini\": 32.7,\"timezones\": [\"UTC−10:00\",\"UTC−09:30\",\"UTC−09:00\",\"UTC−08:00\",\"UTC−04:00\",\"UTC−03:00\",\"UTC+01:00\",\"UTC+03:00\",\"UTC+04:00\",\"UTC+05:00\",\"UTC+11:00\",\"UTC+12:00\"],\"borders\": [\"AND\",\"BEL\",\"DEU\",\"ITA\",\"LUX\",\"MCO\",\"ESP\",\"CHE\"],\"nativeName\":\"France\",\"callingCodes\": [\"33\"],\"topLevelDomain\": [\".fr\"],\"alpha2Code\": \"FR\",\"alpha3Code\":\"FRA\",\"currencies\": [\"EUR\"],\"languages\": [\"fr\"]}]".dataUsingEncoding(NSUTF8StringEncoding)!
        default: return "".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
    
    var cacheIdentifier: String {
        return self.path
    }
}



