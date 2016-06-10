//
//  kanyeREST.swift
//  APIClient
//
//  Created by Arthur Heimbrecht on 30.5.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Moya
import Freddy


enum kanyeREST: Moya.TargetType{
	
	
	/// MARK: Endpoints
	
	case album(title: String)
	case track(title: String)
	
	
	// MARK: Network Abstraction
	
	var baseURL: NSURL { return NSURL(string: "http://www.kanyerest.xyz/api")! }
	
	var path: String {
		switch self {
		case .album(title: let name): return "/album/\(name)"
		case .track(title: let name): return "/track/\(name)"
		}
	}
	
	var method: Moya.Method { return .GET }
	
	var parameters: [String : AnyObject]? {
		switch self {
		case .album(title: let name): return ["title": name]
		case .track(title: let name): return ["title": name]
		default: return nil
		}
	}
	
	// TODO: Provide sample data for testing
	var sampleData: NSData {
		switch self {
		case .album(title: let name): return
		case .track(title: let name): return
		default: return "".dataUsingEncoding(NSUTF8StringEncoding)!
		}
	}
	
}