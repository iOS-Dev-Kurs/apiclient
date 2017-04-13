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
    
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    // @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBAction func moviesButton(_ sender: Any) {
        
        showQuote(for: "movies")
       
    }
    @IBAction func famousButton(_ sender: Any) {
        showQuote(for: "famous")
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = ""
        authorLabel.text = ""
        self.title = "It´s your choice!"
        self.activityView.hidesWhenStopped = true
    
    }
    
    func showQuote(for category: String) {
       
        activityView.startAnimating()
        
        let endpointClosure = { (target: Quotesapi) -> Endpoint<Quotesapi> in
            let headers = [
                "X-Mashape-Key": "gpYkdsl5x9msho9B1uCnd5LtHdVqp1932RLjsn3egoFcCcYng9"
            ]
            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            return defaultEndpoint
                .adding(newHTTPHeaderFields: headers)
        }
        
        let provider = MoyaProvider<Quotesapi>(endpointClosure: endpointClosure)
        
        let query = Quotesapi.quote(category: category)
    
        
        provider.request(query) { result in
            
            self.activityView.stopAnimating()
            switch result {
            case .success(let response):
                do {
                    let jsonResponse = try JSON(data: response.data)
                    print(jsonResponse)
                    let result = try results (json: jsonResponse)
                    self.nameLabel.text = result.quote
                    self.authorLabel.text = result.author
                } catch {
                print(error)
                }
                
        
            case .failure(let error):
                
                print(error)
        
            }
        }
        
    }
}
