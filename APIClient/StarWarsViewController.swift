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

class StarWarsViewController: UIViewController {
    
    var starWAPI : MoyaProvider<SWAPI>!
    
    
    
    
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var starShipLoading: UIActivityIndicatorView!
    @IBOutlet weak var starShipLabel: UILabel!
    @IBOutlet weak var starShipImage: UIImageView!
}