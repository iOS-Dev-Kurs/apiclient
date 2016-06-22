//
//  GlosbeAPITarget.swift
//  APIClient
//
//  Created by Frederik on 29/05/16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Moya

struct GlosbeAPITarget : TargetType
{
    var phrase: String
    var from: String
    var dest: String
    

    var baseURL: NSURL {
        return NSURL(string: "https://glosbe.com/gapi/translate?from=\(from)&dest=\(dest)&format=json&phrase=\(phrase)")!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .GET
    }
    
    var parameters: [String : AnyObject]? {
        return nil
    }
    
    var sampleData: NSData {
        return "".dataUsingEncoding(NSUTF8StringEncoding)!
    }
}