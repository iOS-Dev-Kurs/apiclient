//
//  WeatherViewController.swift
//  APIClient
//
//  Created by Colin Otchere on 05.06.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit
import Moya
import Freddy
import AlamofireImage

class WeatherViewController: UIViewController,UITextFieldDelegate {
    
    
    var forecastAPI: MoyaProvider<ForecastAPI>!
    var googleAPI: MoyaProvider<GoogleGeocodingAPI>!

    var allWeatherData = [WeatherList]()
    
    var weatherObj: WeatherRawData? {
        didSet {
            // Configure view
            self.timezone.text = weatherObj?.timezone
            self.currentWeatherData.text = weatherObj?.dailyWeather.data.first?.summaryGer
            self.temperature.text = String(format:"%.1f",(weatherObj?.currentWeather.temperatur)!)+"°C"
            self.sunset.text = weatherObj?.dailyWeather.data.first?.sunset
            self.sunrise.text = weatherObj?.dailyWeather.data.first?.sunrise
            loadImage((weatherObj?.currentWeather.icon)!)
            print((weatherObj?.dailyWeather.data.count))
            loadForecast(weatherObj!)

        }
    }
    
    var cityObj: CityRawData? {
        didSet{
            self.status.text = cityObj?.status
            
            self.loadWeatherRawData(Coordinate(lat: (cityObj?.result.first?.geometry.location.lat)!,
                lng: (cityObj?.result.first?.geometry.location.lng)!))
            
            self.city.text = cityObj?.result.first?.formatedAdress

        }
    }
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var weatherIconIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    @IBOutlet weak var cityname: UITextField!
    
    @IBOutlet weak var forecastButton: UIBarButtonItem!

    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var timezone: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var currentWeatherData: UILabel!
    @IBOutlet weak var currentWetter: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var status: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityname.delegate = self
        
        self.loadCityRawData(CityResource(name: "Heidelberg"))

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case "ForecastView":
            guard let weatherListViewController = (segue.destinationViewController as? UINavigationController)?.topViewController as? WeatherListViewController else {break}

            weatherListViewController.weather = allWeatherData
            
            if let dotRange = city.text!.rangeOfString(",") {
                city.text!.removeRange(dotRange.startIndex..<city.text!.endIndex)
            }
            
            let cleanCityname = (city.text!.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet()) as NSArray).componentsJoinedByString("")

            weatherListViewController.cityname = cleanCityname
            print(weatherListViewController.weather)
            
        default:
            break
        }
    }
    
    @IBAction func  unwindToWeather(segue: UIStoryboardSegue){
        switch segue.identifier! {
        case "ExitFromButton":
            print("buttonExitToCanvas fired")
        default:
            break
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let name = cityname.text else {
            return true
        }
       // loadWeatherRawData(NamedResource(name: name))
        self.loadCityRawData(CityResource(name: name))
        return true
    }
    
    func loadCityRawData(name: CityResource<CityRawData>){
        loadingIndicator.startAnimating()
        weatherIconIndicator.startAnimating()
        googleAPI.request(.cityRawData(name)){ result in
            self.loadingIndicator.stopAnimating()
            self.weatherIconIndicator.stopAnimating()
            switch result{
            case .Success(let responseData):
                do{
                    try responseData.filterSuccessfulStatusCodes()
                    // Try to parse the response to JSON
                    let json = try JSON(data: responseData.data)
                    // Try to decode the JSON to the required type
                    let cityRawdata = try CityRawData(json: json)
                    // Configure view according to model
                    self.cityObj = cityRawdata
                } catch {
                    print(error)
                    self.status.text = "status: Fehler"
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func loadWeatherRawData(coordinate: Coordinate) {
        loadingIndicator.startAnimating()
        weatherIconIndicator.startAnimating()
        self.status.text = "status: lade..."
        forecastAPI.request(.cityWeather(coordinate: coordinate)) { result in
            self.loadingIndicator.stopAnimating()
            self.weatherIconIndicator.stopAnimating()
            switch result {
            case .Success(let response):
                do {
                    try response.filterSuccessfulStatusCodes()
                    // Try to parse the response to JSON
                    let json = try JSON(data: response.data)
                    // Try to decode the JSON to the required type
                    let weatherData = try WeatherRawData(json: json)
                    // Configure view according to model
                    self.weatherObj = weatherData
                    
                    self.status.text = "status: OK"

                } catch {
                    print(error)
                    self.status.text = "status: Fehler"
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func loadImage(id: String) {
        
        switch id {
        case "clear-day":
            self.weatherIcon.image = (image: UIImage(named: "clear-day"))
            self.weatherIcon.image = self.weatherIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            self.weatherIcon.tintColor = UIColor.whiteColor()
        case "clear-night":
            self.weatherIcon.image = (image: UIImage(named: "partly-cloudy-night"))
            self.weatherIcon.image = self.weatherIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            self.weatherIcon.tintColor = UIColor.whiteColor()
        case "rain":
            self.weatherIcon.image = (image: UIImage(named: "rain"))
            self.weatherIcon.image = self.weatherIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            self.weatherIcon.tintColor = UIColor.whiteColor()
        case "snow":
            self.weatherIcon.image = (image: UIImage(named: "snow"))
            self.weatherIcon.image = self.weatherIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            self.weatherIcon.tintColor = UIColor.whiteColor()
        case "sleet":
            self.weatherIcon.image = (image: UIImage(named: "sleet"))
            self.weatherIcon.image = self.weatherIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            self.weatherIcon.tintColor = UIColor.whiteColor()
        case "wind":
            self.weatherIcon.image = (image: UIImage(named: "wind"))
            self.weatherIcon.image = self.weatherIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            self.weatherIcon.tintColor = UIColor.whiteColor()
        case "fog":
            self.weatherIcon.image = (image: UIImage(named: "fog"))
            self.weatherIcon.image = self.weatherIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            self.weatherIcon.tintColor = UIColor.whiteColor()
        case "cloudy":
            self.weatherIcon.image = (image: UIImage(named: "cloudy"))
            self.weatherIcon.image = self.weatherIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            self.weatherIcon.tintColor = UIColor.whiteColor()
        case "partly-cloudy-day":
            self.weatherIcon.image = (image: UIImage(named: "partly-cloudy-day"))
            self.weatherIcon.image = self.weatherIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            self.weatherIcon.tintColor = UIColor.whiteColor()
        case "partly-cloudy-night":
            self.weatherIcon.image = (image: UIImage(named: "partly-cloudy-night"))
            self.weatherIcon.image = self.weatherIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            self.weatherIcon.tintColor = UIColor.whiteColor()
        case "hail":
            self.weatherIcon.image = (image: UIImage(named: "hail"))
            self.weatherIcon.image = self.weatherIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            self.weatherIcon.tintColor = UIColor.whiteColor()
        case "thunderstorm":
            self.weatherIcon.image = (image: UIImage(named: "thunderstorm"))
            self.weatherIcon.image = self.weatherIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            self.weatherIcon.tintColor = UIColor.whiteColor()
        case "tornado":
            self.weatherIcon.image = (image: UIImage(named: "wind"))
            self.weatherIcon.image = self.weatherIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            self.weatherIcon.tintColor = UIColor.whiteColor()
        default:
            self.weatherIcon.image = (image: UIImage(named: "sun"))
            self.weatherIcon.image = self.weatherIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            self.weatherIcon.tintColor = UIColor.whiteColor()
        }
    }
    
    func loadForecast(obj: WeatherRawData){
        
        let days: Int
        days = obj.dailyWeather.data.count-1
        
        if !allWeatherData.isEmpty
        {
            allWeatherData = []
        }
        
        if days > 0{
        
            for index in 1...days {
        
                let obj = WeatherList(day: obj.dailyWeather.data[index].date,
                                      maxTemp: String(format: "%.1f", obj.dailyWeather.data[index].maxTemp),
                                      minTemp:  String(format: "%.1f", obj.dailyWeather.data[index].minTemp),
                                      sunrise: obj.dailyWeather.data[index].sunrise,
                                      sunset: obj.dailyWeather.data[index].sunset,
                                      image: obj.dailyWeather.data[index].icon)
                allWeatherData.append(obj!)
            }
        }
        else {
            self.forecastButton.enabled = false
        }
    }
}