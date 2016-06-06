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
    
    let swAPI = MoyaProvider<SWAPI>()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }

}

