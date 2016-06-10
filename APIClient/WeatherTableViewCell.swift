//
//  WeatherTableViewCell.swift
//  APIClient
//
//  Created by Colin Otchere on 10.06.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//
import UIKit
import Foundation

class WeatherTableViewCell: UITableViewCell{
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
    }
}

