//
//  VideoNetwork.swift
//  TrendingMovies
//
//  Created by Marcin on 04/09/2016.
//  Copyright © 2016 MarcinSteciuk. All rights reserved.
//

import Foundation
import Alamofire

struct Network {
    
    let headerContentTypeKey = "Content-Type"
    let headerAcceptKey = "Accept"
    let headerContentJSONValue = "application/json"
    let headerTraktVersionKey = "trakt-api-version"
    let headerTraktApplicationKey = "trakt-api-key"
    
    let apiKey = "0e7e55d561c7e688868a5ea7d2c82b17e59fde95fbc2437e809b1449850d4162"
    let apiVersionKey = "2"
    
    let scheme: String
    let host: String
    let path: String
    let queryParameters: [NSURLQueryItem]
    
    init(scheme: String, host: String, path: String, queryParameters: [NSURLQueryItem]) {
        
        self.scheme = scheme
        self.host = host
        self.path = path
        self.queryParameters = queryParameters
    }
    
    func download() {
        
        if let url = constructURL() {
            
            let mutableURLRequest = NSMutableURLRequest(URL: url)
            
            let headers = [headerContentTypeKey: headerContentJSONValue, headerAcceptKey:  headerContentJSONValue, headerTraktVersionKey: apiVersionKey, headerTraktApplicationKey: apiKey]
            
            Alamofire.request(.GET, mutableURLRequest, parameters: nil, encoding: .JSON, headers: headers).validate().responseJSON {  response in switch response.result {
                
            case .Success(let JSON):
                
                print("Success with JSON: \(JSON)")
                
            case .Failure(let error):
                
                print("Request failed with error: \(error)")
                
                }
            }
        }
    }
    
    private func constructURL() -> NSURL? {
        
        let urlComponents = NSURLComponents()
        urlComponents.host = host
        urlComponents.scheme = scheme
        urlComponents.path = path
        urlComponents.queryItems = queryParameters
        
        return urlComponents.URL
    }
}