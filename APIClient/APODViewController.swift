//
//  APODViewController.swift
//  APIClient
//
//  Created by Alex Golovin on 12.04.17.
//  Copyright © 2017 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import UIKit
import Moya
import Freddy
import AlamofireImage

class APODViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var inputAPODQuerry: UITextField!
    
    @IBOutlet weak var datePickerField: UIDatePicker!
    
    @IBAction func dateConfirm(_ sender: Any) {
        
        
        
        let date = datePickerField.date
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        let dateString = formater.string(from: date)
        
        self.imageLoading.startAnimating()
        
        let provider = MoyaProvider<APODapi>()
        
        let query = APODapi.apodImage(date: dateString)
        
        provider.request(query) {result in
            self.imageLoading.stopAnimating()
            
            switch result {
            case .success(let response):
                
                //print(String(data: response.data)) response.data
                do{
                    
                    let jsonResponse = try JSON(data: response.data)
                    print(jsonResponse)
                    let apodResult = try APODResult(json: jsonResponse)
                    self.outputAPOD.af_setImage(withURL: apodResult.url)
                } catch {
                    print(error)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    @IBOutlet weak var imageLoading: UIActivityIndicatorView!

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let input = inputAPODQuerry.text else {
        //guard let input = datePickerField.text else {
            return true
        }
        
        
        inputAPODQuerry.resignFirstResponder()
        return true
    }
    
    @IBOutlet weak var outputAPOD: UIImageView!
}
