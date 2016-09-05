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

class CountryViewController: UIViewController {
    
    var provider: MoyaProvider<countryAPI>!
    
    var countryToDisplay: Country?
    
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var CapitalLabel: UILabel!
    @IBOutlet var populationLabel: UILabel!

    @IBOutlet var showCountryLabel: UILabel!
    @IBOutlet var showCapitalLabel: UILabel!
    @IBOutlet var showPopulationLabel: UILabel!
    
    @IBOutlet var searchField: UITextField!
    
    @IBAction func searchButtonPressed(sender: AnyObject) {
        if let countryToFind = searchField.text {
        findCountry(countryToFind)
    } else {
        searchField.text = "please enter a country"
        }
    }
    /*
    func getCapitalOf(Country: String) {
        provider.request(.fullName(name: Country)) {result in
            switch result {
            case let .Success(moyaResponse):
                let data = moyaResponse.data
                var json:AnyObject?
                
                do
                {
                    json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
                    print(json)
                } catch {
                    print(error)
                }
                
                guard let jArray = json as? [NSMutableDictionary]
                    else {
                        print("format error")
                        break
                    }
                
                guard let capital = jArray[0]["capital"] as? String else {
                    print("capital not a String")
                    break
                }
                self.capitalLabel.text = capital
                
            case let .Failure(error):
                print(error)
            }
        }
    }
    */
    
    func findCountry(CountryToFind: String) {
        provider.request(.fullName(name: CountryToFind)) {result in
            switch result {
            case let .Success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    let someCountry = try json.array().map(Country.init)[0]
                    self.countryToDisplay = someCountry
                    self.displayCountry(self.countryToDisplay)
                }
                catch {
                    print(error)
                }
                
            case let .Failure(error):
                print(error)
            }
        }
    }
    
    func displayCountry(countryToDisplay: Country?) {
        if countryToDisplay != nil {
            showCountryLabel.text = countryToDisplay!.name
            showCapitalLabel.text = countryToDisplay!.capital
            showPopulationLabel.text = String(countryToDisplay!.population)
        } else {
            searchField.text = "no country to display"
        }
    }


}

