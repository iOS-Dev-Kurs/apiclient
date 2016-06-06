//
//  AppDelegate.swift
//  APIClient
//
//  Created by Nils Fischer on 20.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import UIKit
import Moya
import Freddy

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	/// The PokeAPI Provider representing the Server
	let kanyeAPI = MoyaProvider<kanyeREST>()
	
	let allalbumnames = [
		"the_college_dropout",
		"late_registration",
		"graduation",
		"808s_&amp;_heartbreak",
		"my_beautiful_dark_twisted_fantasy",
		"watch_the_throne",
		"yeezus",
		"the_life_of_pablo"
	]
	
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		
		if let APIViewController = (window?.rootViewController as? UINavigationController)?.topViewController as? APIViewController {
			print("test")
			// Pass the PokeAPI Provider on to the root view controller
			APIViewController.kanyeAPI = kanyeAPI
			APIViewController.allalbumnames = allalbumnames
			
		}
		
		if let albumViewController = (window?.rootViewController as? UINavigationController)?.topViewController as? albumViewController {
			
			print("albumviewcontroller")
			//print(albumnames)
			var allalbums: [Album] = []
			/*for albumname in self.allalbumnames{
				kanyeAPI.request(kanyeREST.album(title: albumname)){
					result in
					//print(title)
					switch result {
					case .Success(let response):
						do {
							try response.filterSuccessfulStatusCodes()
							//print(response)
							let json = try JSON(data: response.data)
							let tracks = try json.array("result").map(Track.init)
							allalbums.append(Album(tracksfetched: tracks))
							//print(self.allalbums[0])
							//print(allalbums)
						} catch {
							print(error)
							break
						}
					case .Failure(let error):
						print("failure")
						print(error)
						break
					}
				}
			}*/
			
			
			albumViewController.kanyeAPI = kanyeAPI
			albumViewController.allalbumnames = self.allalbumnames
			//albumViewController.allalbums = allalbums
			print("albums loaded")
			
		}
		
		return true
	}
	
}

