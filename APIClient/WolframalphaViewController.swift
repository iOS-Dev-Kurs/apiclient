//
//  WolframalphaViewController.swift
//  APIClient
//
//  Created by Katja D on 12.04.17.
//  Copyright © 2017 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import UIKit
import Moya

class WolframalphaViewController: UIViewController,
    UITextFieldDelegate{
    
    
    @IBOutlet var inputTextfield: UITextField!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    

    @IBOutlet weak var answerLabel: UITextView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let input = textField.text else {
            return true
        }
        loadingIndicator.startAnimating()
        
        let provider = MoyaProvider<Wolframalphaapi>()
        
        let query = Wolframalphaapi.shortAnswer(query: input)
        
        provider.request(query) { result in
            
        self.loadingIndicator.stopAnimating()
            
            switch result {
            case .success(let response):
               let answer = String(data: response.data,
                       encoding: .utf8)
                self.answerLabel.text = answer
                
                
            case .failure(let error):
            
            print(error)
                
            }
            
        }
        
        return true
    }
    
    
    
}
