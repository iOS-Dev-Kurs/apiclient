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
	let kanyeAPI = MoyaProvider<kanyeREST>()
	
	/*let albums = [
		Album(title: "the_college_dropout"),
		Album(title: "late_registration"),
		Album(title: "graduation"),
		Album(title: "808s_&amp;_heartbreak"),
		Album(title: "my_beautiful_dark_twisted_fantasy"),
		Album(title: "watch_the_throne"),
		Album(title: "yeezus"),
		Album(title: "the_life_of_pablo")
	]*/
	
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		
		if let APIViewController = (window?.rootViewController as? UINavigationController)?.topViewController as? APIViewController {
			print("test")
			// Pass the PokeAPI Provider on to the root view controller
			APIViewController.kanyeAPI = kanyeAPI
			
		}
		
		/*if let albumViewController = (window?.rootViewController as? UINavigationController)?.topViewController as? albumViewController {
			
			// Pass the PokeAPI Provider on to the root view controller
			albumViewController.kanyeAPI = kanyeAPI
			albumViewController.allalbums = albums
			
		}*/
		
		return true
	}
	
}

