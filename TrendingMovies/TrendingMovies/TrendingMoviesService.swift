//
//  JSONService.swift
//  TrendingMovies
//
//  Created by Marcin on 03/09/2016.
//  Copyright © 2016 MarcinSteciuk. All rights reserved.
//

import Foundation
import Alamofire

struct TrendingMoviesService {
    
    func getTrendingMovies() {
        
        let extendedQueryItem = NSURLQueryItem(name: "extended", value: "full,images")
        let pageQueryItem = NSURLQueryItem(name: "page", value: "1")
        let limitQueryItem = NSURLQueryItem(name: "limit", value: "50")
        
        let network = Network(scheme: "https", host: "api.trakt.tv", path: "/movies/trending", queryParameters: [pageQueryItem, limitQueryItem, extendedQueryItem])
        
        network.download()
    }
}

