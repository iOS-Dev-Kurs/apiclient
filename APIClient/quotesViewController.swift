//
//  quotesViewController.swift
//  APIClient
//
//  Created by Elvira  Beisel on 12.04.17.
//  Copyright © 2017 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import UIKit
import Moya

import Freddy

class quotesViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let input = textField.text else {
            return true
        }
        
        let endpointClosure = { (target: Quotesapi) -> Endpoint<Quotesapi> in
            let headers = [
                "X-Mashape-Key": "gpYkdsl5x9msho9B1uCnd5LtHdVqp1932RLjsn3egoFcCcYng9"
            ]
            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            return defaultEndpoint
                .adding(newHTTPHeaderFields: headers)
        }
        
    
        
        let provider = MoyaProvider<Quotesapi>(endpointClosure: endpointClosure)
        
        let query = Quotesapi.quote(category: input)
        
        provider.request(query) { result in
            
            switch result {
            case .success(let response):
                do {
                    let jsonResponse = try JSON(data: response.data)
                    print(jsonResponse)
                    let result = try results (json: jsonResponse)
                    self.nameLabel.text = result.quote
                } catch {
                print(error)
                }
                
                
            case .failure(let error):
                
                print(error)
            
            }
        }
        
        return true
    }
}
