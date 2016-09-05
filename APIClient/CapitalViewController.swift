//
//  testViewController.swift
//  APIClient
//
//  Created by Lucas Moeller on 23.08.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import UIKit
import Freddy
import Moya
import Alamofire

class CapitalViewController: UIViewController {
    
    var provider: MoyaProvider<countryAPI>!

    func getCapitalOf(Country: String) -> (Capital: String?, error: ErrorType?){
        var returnCapital: String? = nil
        var returnError: ErrorType? = nil
        provider.request(.fullName(name: Country)) {result in
            switch result {
            case let .Success(moyaResponse):
                let data = moyaResponse.data
                guard let json = try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) else {
                    break
                }
                guard let jsonArray = json as? [String: AnyObject] else {
                    break
                }
                guard let capital = jsonArray["capital"] as? String else {
                    break
                }
                returnCapital = capital
            case let .Failure(error):
                print("Error")
            }
        }
        return (returnCapital, returnError)
    }
    
    

}

