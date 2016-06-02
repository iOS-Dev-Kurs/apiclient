//
//  StarWarsViewController.swift
//  APIClient
//
//  Created by Christoph Blattgerste on 24.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit
import Freddy
import Moya
import AlamofireImage

class StarWarsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var starWAPI : MoyaProvider<SWAPI>!
    
    var entrieDataSS: Starships? {
        didSet {
            outputOne.text = entrieDataSS?.starshipClass
            outputTwo.text = entrieDataSS?.costInCredits
            outputZero.text = entrieDataSS?.name
            labelOne.text = "Its class:"
            labelTwo.text = "Its costs[credits]:"
            labelZero.text = "Starships name:"
        }
    }
    var entrieDataPl: Planets? {
        didSet {
            outputOne.text = entrieDataPl?.terrain
            outputTwo.text = entrieDataPl?.population
            outputZero.text = entrieDataPl?.name
            labelOne.text = "Its terrain:"
            labelTwo.text = "Its population:"
            labelZero.text = "Planets name:"
            
        }
    }
    var entrieDataSp: Species? {
        didSet {
            outputZero.text = entrieDataSp?.name
            outputOne.text = entrieDataSp?.homeworld
            outputTwo.text = entrieDataSp?.language
            labelZero.text = "Species name:"
            labelOne.text = "Its homeworld:"
            labelTwo.text = "Its language:"
        }
    }

    
    @IBOutlet weak var sWPickerView: UIPickerView!
    @IBOutlet weak var pickerLabel: UILabel!
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelZero: UILabel!
    @IBOutlet weak var outputOne: UILabel!
    @IBOutlet weak var outputTwo: UILabel!
    @IBOutlet weak var outputZero: UILabel!
    @IBOutlet weak var numberSelection: UITextField!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBAction func actNumberSelection(sender: AnyObject) {
        sender.resignFirstResponder()
        switch selectedEndpoint {
        case "Starship":
            loadStarship(NamedResource(name: String(numberSelection)))
        case "Planet":
            loadPlanet(NamedResource(name: String(numberSelection)))
        case "Specie":
            loadSpecies(NamedResource(name: String(numberSelection)))
        default:
            break
        }
    }
    
    let pickerData = ["Starship","Planet","Specie"]
        
    private var selectedEndpoint = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sWPickerView.dataSource = self
        self.sWPickerView.delegate = self
        self.entrieDataSS = nil
        self.entrieDataSS = nil
        self.entrieDataSp = nil
    }
    
//    Functions to initialize UIPickerView
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerLabel.text = "Select a \(pickerData[row]):"
        selectedEndpoint = pickerData[row]
    }
    
//    load selected Endpoint from API URL
//    depending on PickerWheel selection
    func loadStarship(starship: NamedResource<Starships>) {
        loadingIndicator.startAnimating()
        starWAPI.request(.starships(starship)) { result in
                    self.loadingIndicator.stopAnimating()
                    switch result {
                    case .Success(let response):
                        do {
                            try response.filterSuccessfulStatusCodes()
                            // Try to parse the response to JSON
                            let json = try JSON(data: response.data)
                            // Try to decode the JSON to the required type
                            let star_ship = try Starships(json: json)
                            // Configure view according to model
                            self.entrieDataSS = star_ship
                        } catch {
                            print(error)
                        }
                    case .Failure(let error):
                        print(error)
                    }
            }
    }
    func loadPlanet(planet: NamedResource<Planets>) {
        loadingIndicator.startAnimating()
        starWAPI.request(.planets(planet)) { result in
            self.loadingIndicator.stopAnimating()
            switch result {
            case .Success(let response):
                do {
                    try response.filterSuccessfulStatusCodes()
                    // Try to parse the response to JSON
                    let json = try JSON(data: response.data)
                    // Try to decode the JSON to the required type
                    let pla_net = try Planets(json: json)
                    // Configure view according to model
                    self.entrieDataPl = pla_net
                } catch {
                    print(error)
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func loadSpecies(specie: NamedResource<Species>) {
        loadingIndicator.startAnimating()
        starWAPI.request(.species(specie)) { result in
            self.loadingIndicator.stopAnimating()
            switch result {
            case .Success(let response):
                do {
                    try response.filterSuccessfulStatusCodes()
                    // Try to parse the response to JSON
                    let json = try JSON(data: response.data)
                    // Try to decode the JSON to the required type
                    let spe_cies = try Species(json: json)
                    // Configure view according to model
                    self.entrieDataSp = spe_cies
                } catch {
                    print(error)
                }
            case .Failure(let error):
                print(error)
            }
        }
    }

}
