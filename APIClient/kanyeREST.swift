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
		case .album(title: let name): return "{\"result\": [{\"album\": \"\(name)\",\"title\": \"generic title no.1 \",\"lyrics\": \"bla bla\",},{\"album\": \"\(name)\",\"title\": \"generic title no. 2\",\"lyrics\": \"more bla bla\",},]}".dataUsingEncoding(NSUTF8StringEncoding)!
		case .track(title: let name): return "{\"album\": \"graduation\", \"title\": \"\(name)\", \"lyrics\": \"lyrics\nyeah yeah yeah \n lyrics lyrics \n damn lyrics, i'm da best ya\", }".dataUsingEncoding(NSUTF8StringEncoding)!
		default: return "".dataUsingEncoding(NSUTF8StringEncoding)!
		}
	}
	
}