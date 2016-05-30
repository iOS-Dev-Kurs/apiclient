//
//  AppDelegate.swift
//  APIClient
//
//  Created by Nils Fischer on 20.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit
import Moya

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    /// The SWAPI Provider representing the Server
    let swAPI = MoyaProvider<SWAPI>()
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        if let starwarsViewController = (window?.rootViewController as? UINavigationController)?.topViewController as? SWViewController {
            
            // Pass the SWAPI Provider on to the root view controller
            starwarsViewController.swAPI = swAPI
            
        }
        
        return true
    }

}

