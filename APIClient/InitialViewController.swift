//
//  InitialViewController.swift
//  APIClient
//
//  Created by Frederik on 29/05/16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Moya
import Freddy

class InitialViewController : UIViewController
{
    var glosbeAPI = MoyaProvider<GlosbeAPITarget>()
    
    func handleTranslationRequestResponseData(data: NSData) throws
    {
        let j = try JSON(data: data)
        let a = try j.array("tuc")
        if a.count != 0 {
            let A = try a[0].dictionary("phrase")
            let J = A["text"]
            destContent.text = J?.description
        } else {
            destContent.text = "(• ε •)"
        }
    }
    
    func invokeTranslationRequest(phrase: String, from: String, dest: String)
    {
        let target = GlosbeAPITarget(phrase: phrase, from: from, dest: dest)
        
        glosbeAPI.request(target) { result in
            switch result {
            case .Success(let response):
                do {
                    try response.filterSuccessfulStatusCodes()
                    try self.handleTranslationRequestResponseData(response.data)
                } catch {
                    print(error)
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    //NOTE(Frederik): Controller implementation
    
    @IBOutlet weak var destContent: UILabel!
    @IBOutlet weak var textInputField: UITextField!
    
    //NODE(Frederik): Text field input CB
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        guard let name = textField.text else {
            return true
        }
        self.invokeTranslationRequest(name, from: "eng", dest: "deu")
        return true
    }
    
}