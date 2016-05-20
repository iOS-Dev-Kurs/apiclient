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
    
    /// The PokeAPI Provider representing the Server
    let pokeAPI = MoyaProvider<PokeAPI>()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let pokemonViewController = (window?.rootViewController as? UINavigationController)?.topViewController as? PokemonViewController {
            
            // Pass the PokeAPI Provider on to the root view controller
            pokemonViewController.pokeAPI = pokeAPI
            
        }
        
        return true
    }

}

