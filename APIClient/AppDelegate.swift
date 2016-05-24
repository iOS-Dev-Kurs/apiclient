//
//  AppDelegate.swift
//  APIClient
//
//  Created by Nils Fischer on 20.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let starWAPI = MoyaProvider<SWAPI>()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        if let starWarsViewController = (window?.rootViewController as? UINavigationController)?.topViewController as? StarWarsViewController {
            
        }
        
        return true
    }

}

