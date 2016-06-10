//
//  Weather.swift
//  APIClient
//
//  Created by Colin Otchere on 09.06.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit

struct WeatherList {
    
    let day: String
    let sunset: String
    let sunrise: String
    let maxTemp: String
    let minTemp: String
    let imageName: String
    
    init?(day: String,maxTemp: String, minTemp: String, sunrise: String, sunset: String, image: String){
        self.day = day
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.sunrise = sunrise
        self.sunset = sunset
        self.imageName = image
    }
    
}