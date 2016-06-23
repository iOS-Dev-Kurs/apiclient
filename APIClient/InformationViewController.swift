//
//  InformationViewController.swift
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


class InformationViewController: UIViewController {
    
    var peoples : SWPeoples?

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var gender: UILabel!
    
    @IBOutlet weak var height: UILabel!
    
    @IBOutlet weak var mass: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = peoples?.name
        gender.text = peoples?.gender
        height.text = peoples?.height
        mass.text = peoples?.mass
        
    }
    
    
}


