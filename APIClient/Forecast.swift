//
//  Weather.swift
//  APIClient
//
//  Created by Colin Otchere on 05.06.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Freddy
import UIKit

struct WeatherRawData:JSONDecodable{
    
    let currentWeather: Weather
    let dailyWeather: Data
    let timezone: String
    
    init(json: JSON) throws {
        self.timezone = try json.string("timezone")
        self.currentWeather = try json.decode("currently")
        self.dailyWeather = try json.decode("daily")
    }
}

struct Data: JSONDecodable{
    
    let data: [WeatherData]
    
    init(json: JSON) throws {
        self.data = try json.arrayOf("data")
    }
}
struct Weather:JSONDecodable{
        
    let time: Int
    let summary: String
    let icon: String
    var temperatur: Double
    var summaryGer: String
    
    init(json: JSON) throws {
            
        self.summary = try json.string("summary")
        self.time = try json.int("time")
        self.icon = try json.string("icon")
        self.temperatur = try json.double("temperature")
        self.summaryGer = ""
        convertToCelsius()
        self.summaryGer = translate(self.icon)
    }

    mutating func convertToCelsius(){
        self.temperatur = (self.temperatur - 32)*5/9
    }
    
    mutating func translate(weathertext: String) -> String{
        switch weathertext {
        case "clear-day":
            return "Heiter"
        case "clear-night":
            return "klare Nacht"
        case "rain":
            return "Regen"
        case "snow":
            return "Schnee"
        case "sleet":
            return "Schneeregen"
        case "wind":
            return "windig"
        case "fog":
            return "neblig"
        case "cloudy":
            return "bewölckt"
        case "partly-cloudy-day":
            return ""
        case "partly-cloudy-night":
            return "leicht bewölkt"
        case "hail":
            return "Hagel"
        case "thunderstorm":
            return "Gewitter"
        case "tornado":
            return "Tornado"
        default:
            return "keine Wetterdaten"
            
        }
    }
}

struct WeatherData: JSONDecodable{
    
    var time: Double
    var date:String
    let icon: String
    var sunriseTime: Double
    var sunsetTime: Double
    var minTemp: Double
    var maxTemp: Double
    var summaryGer: String
    
    var sunrise: String
    var sunset: String
    
    init(json: JSON) throws {
        self.time = try json.double("time")
        self.icon = try json.string("icon")
        self.sunriseTime = try json.double("sunriseTime")
        self.sunsetTime = try json.double("sunsetTime")
        self.minTemp = try json.double("temperatureMin")
        self.maxTemp = try json.double("temperatureMax")
        self.summaryGer = "av"
        self.date = ""
        self.sunrise=""
        self.sunset=""
        
        self.minTemp =  convertToCelsius(self.minTemp)
        self.maxTemp = convertToCelsius(self.maxTemp)
        
        self.sunrise = convertUnixTimeToDate(self.sunriseTime)
        self.sunset = convertUnixTimeToDate(self.sunsetTime)
        
        self.date = dayStringFromTime(self.time)
        self.summaryGer = translateToGer(self.icon)
    }
    
    mutating func convertToCelsius(temperatur: Double) -> Double{
        let tmpT = (temperatur - 32)*5/9
        return tmpT
    }
    
    mutating func convertUnixTimeToDate(time: Double) -> String{
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "hh:mm"
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        
        let date = NSDate(timeIntervalSince1970: time)
        
        return dateFormatter.stringFromDate(date)
    }
    
    mutating func dayStringFromTime(unixTime: Double) -> String {
        
        let dateFormatter = NSDateFormatter()

        let date = NSDate(timeIntervalSince1970: unixTime)
        
        dateFormatter.locale = NSLocale(localeIdentifier: NSLocale.currentLocale().localeIdentifier)
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.stringFromDate(date)
    }
    
    mutating func translateToGer(weathertext: String) ->String{
        switch weathertext {
        case "clear-day":
            return "Heiter"
        case "clear-night":
            return "klare Nacht"
        case "rain":
            return "Regen"
        case "snow":
            return "Schnee"
        case "sleet":
            return "Schneeregen"
        case "wind":
            return "windig"
        case "fog":
            return"neblig"
        case "cloudy":
           return "bewölckt"
        case "partly-cloudy-day":
            return "leicht bewölkt"
        case "partly-cloudy-night":
            return "leicht bewölkt"
        case "hail":
            return "Hagel"
        case "thunderstorm":
            return "Gewitter"
        case "tornado":
            return "Tornado"
        default:
            return "keine Wetterdaten"
            
        }
    }
}



