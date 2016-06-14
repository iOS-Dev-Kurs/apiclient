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
    
    // PostCodeApi Provider represents the Server
    let postCodeApi = MoyaProvider<Zippopotam>()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // pass PostCodeApi Provider on to the root vier controller
        if let mainViewController = (window?.rootViewController as? UINavigationController)?.topViewController as? MainViewController {
            
            // Pass the PokeAPI Provider on to the root view controller
            mainViewController.postCodeApi = postCodeApi
                
                   }
        return true
    }

}

