//
//  WeatherListViewController.swift
//  APIClient
//
//  Created by Colin Otchere on 07.06.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import UIKit

class WeatherListViewController: UITableViewController{
    
    var weather: [WeatherList]?
    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (weather?.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "WeatherCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! WeatherTableViewCell

        cell.maxTemp.text = weather![indexPath.row].maxTemp + "°C"
        cell.minTemp.text = weather![indexPath.row].minTemp + "°C"
        cell.sunrise.text = weather![indexPath.row].sunrise
        cell.sunset.text = weather![indexPath.row].sunset
        cell.dayLabel.text = weather![indexPath.row].day
        cell.weatherImage.image = (image: UIImage(named: weather![indexPath.row].imageName))
        
        cell.weatherImage.image = cell.weatherImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        cell.weatherImage.tintColor = UIColor.whiteColor()
        
        return cell
    }
}