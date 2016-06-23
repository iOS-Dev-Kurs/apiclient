//
//  SearchViewController.swift
//  APIClient
//
//  Created by logosal mac on 06.06.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import UIKit
import Freddy
import Moya
import AlamofireImage


class SearchViewController: UIViewController {
    
    var starWarsAPI : MoyaProvider<SWAPI>!
    
    var peoples: SWPeoples? {
        didSet {
            
// Nur um Textfeld bei Zurückgehen auf Suchbegriff zu setzen
            
//            self.searchTextfield.text = peoples?.name
        }
    }
    
    @IBOutlet weak var searchTextfield: UITextField!
    @IBAction func buttonLoad(sender: AnyObject) {
        loadPeoples(Int(searchTextfield.text!) ?? 0)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showInformation" {
            
            guard let informationViewController = (segue.destinationViewController as?InformationViewController) else {
                return
            }
            guard let peoplesInfo = self.peoples else {
                return
            }
            
//        Übergabe
            informationViewController.peoples = peoplesInfo
            
        }
        
    }
    
    func loadPeoples(peoples: Int) {
        starWarsAPI.request(.people(id: peoples)) { result in
            switch result {
            case .Success(let response):
                do {
                    try response.filterSuccessfulStatusCodes()
                    // Try to parse the response to JSON
                    let json = try JSON(data: response.data)
                    // Try to decode the JSON to the required type
                    let people = try SWPeoples(json: json)
                    // Configure view according to model
                    self.peoples = people
                    self.performSegueWithIdentifier("showInformation", sender: nil)
                } catch {
                    print(error)
                }
            case .Failure(let error):
                print(error)
            }
        }
    }

}






