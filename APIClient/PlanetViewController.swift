//
//  PlanetViewController.swift
//  APIClient
//
//  Created by Kleimaier, Dennis on 23.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Moya
import Freddy

class PlanetViewController: UIViewController {
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var planetAPI: MoyaProvider<PlanetAPI>!
 
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var planetLab: UILabel!
    
    
    func loadPlanet(planet: NamedResource<Planet>){
        planetAPI.request(.planet(planet)){ result in
            switch result {
            case .Success(let response):
                do {
                    try response.filterSuccessfulStatusCodes()
                    // Try to parse the response to JSON
                    //let json = try JSON(data: response.data)
                    // Try to decode the JSON to the required type
                    //let pokemonSpecies = try Planet(json: json)
                    // Configure view according to model
                    //self.planet = pokemonSpecies
                    print(response)
                } catch {
                    print(error)
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        guard let name = textField.text else {
            return true
        }
        self.loadPlanet(NamedResource(name: name))
        return true
    }
}