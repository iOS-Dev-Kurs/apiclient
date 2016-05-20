//
//  APIResource.swift
//  APIClient
//
//  Created by Nils Fischer on 21.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Moya
import Freddy
import AwesomeCache



/**
 Representation for a resource that may or may not be loaded yet.
 
 It is based on two generic types:
 
 - The `Target` is a `Moya.TargetType` that abstracts the API. It must also be `Cacheable` so that responses can be cached.
 - The `Resource` is a `Freddy.JSONDecodable` type so that responses from the API can be directly parsed to JSON and decoded to the expected type.
 
 You are free to use this utility or implement your own way to keep track of loaded and not loaded resources.
 
 - seealso: MoyaProvider.request<Resource: Freddy.JSONDecodable>(_:completion:)
*/
enum APIResource<Target: Moya.TargetType, Resource: Freddy.JSONDecodable where Target: Cacheable> {
    
    case notLoaded(Target)
    case loading(Moya.Cancellable)
    case loaded(Resource)
    case failed(Target, error: ErrorType)
    
}


// MARK: - Requesting Resources

extension MoyaProvider where Target: Cacheable {
    
    /// Requests the resource from the server. Immediately returns with the updated resource status, usually `.loading`. If a cached response is found, returns the `.loaded` resource immediately.
    func request<Resource: Freddy.JSONDecodable>(target: Target, completion: (APIResource<Target, Resource>) -> Void) -> APIResource<Target, Resource> {
        
        // Check for cached data first
        if let cachedResponse = resourceCache[target.cacheIdentifier] {
            do {
                let json = try JSON(data: cachedResponse)
                let resource = try Resource(json: json)
                dispatch_async(dispatch_get_main_queue()) {
                    completion(.loaded(resource))
                }
                return .loaded(resource)
            } catch {
                // Invalidate cache and proceed to loading the request
                resourceCache[target.cacheIdentifier] = nil
            }
        }
        
        // Load the resource from the server
        return .loading(
            self.request(target) { result in
                switch result {
                case .Success(let response):
                    do {
                        try response.filterSuccessfulStatusCodes()
                        // Try to parse the response to JSON
                        let json = try JSON(data: response.data)
                        // Try to decode the JSON to the required type
                        let resource = try Resource(json: json)
                        // Cache the response and complete
                        resourceCache[target.cacheIdentifier] = response.data
                        completion(.loaded(resource))
                    } catch {
                        completion(.failed(target, error: error))
                    }
                case .Failure(let error):
                    completion(.failed(target, error: error))
                }
            }
        )
    }
    
}

/// A persistent cache for resources
private let resourceCache = try! Cache<NSData>(name: "APIResource")

protocol Cacheable {
    
    /// A key used for identification in a cache
    var cacheIdentifier: String { get }
    
}
