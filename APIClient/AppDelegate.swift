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

    let googleAPI = MoyaProvider<GoogleGeocodingAPI>()
    let forecastAPI = MoyaProvider<ForecastAPI>()

    func application(avarication: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        if let weatherviewcontroller = (window?.rootViewController as? UINavigationController)?.topViewController as? WeatherViewController {
            
            // Pass the PokeAPI Provider on to the root view controller
            weatherviewcontroller.forecastAPI = forecastAPI
            weatherviewcontroller.googleAPI = googleAPI
        }
        
        return true
    }
    
    // MARK: State Preservation
    func application(application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    func application(application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
    }

}

