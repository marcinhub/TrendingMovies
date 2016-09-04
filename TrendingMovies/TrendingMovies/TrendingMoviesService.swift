//
//  JSONService.swift
//  TrendingMovies
//
//  Created by Marcin on 03/09/2016.
//  Copyright © 2016 MarcinSteciuk. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct TrendingMoviesService {
    
    private let extendedKey = "extended"
    
    func getTrendingMovies(completion:(([Movie]?, NSError?) -> ())) {
        
        let extendedQueryItem = NSURLQueryItem(name: extendedKey, value: "full,images")
        let pageQueryItem = NSURLQueryItem(name: "page", value: "1")
        let limitQueryItem = NSURLQueryItem(name: "limit", value: "50")
        
        let network = Network(scheme: "https", host: "api.trakt.tv", path: "/movies/trending", queryParameters: [pageQueryItem, limitQueryItem, extendedQueryItem])
        
        network.download { (json, error) in
            
            if error == nil {
                
                if let json = json {
                    
                    let moviesParser = TrendingMoviesParser(trendingMoviesArray: json)
                    let movies = moviesParser.getMovies()
                    
                    completion(movies, nil)

                }
            }
            
            else {
                completion(nil, error)
            }  
        }
    }
}

struct TrendingMoviesParser {
    
    let trendingMoviesArray: [[String: AnyObject]]
    
    init(trendingMoviesArray: [[String: AnyObject]]) {
        
        self.trendingMoviesArray = trendingMoviesArray
    }
    
    func getMovies() -> [Movie] {
        
        let json = JSON(trendingMoviesArray)
        
        var movies = [Movie]()
        if let moviesArray = json.array {
            for movie in moviesArray {
                let movieModel = Movie()
                if let movieModelDictonary = movie.dictionary {
                    if let movieData = movieModelDictonary["movie"]?.dictionary {
                        if let movieTitle = movieData["title"]?.string {
                            movieModel.title = movieTitle
                        }
                        if let movieOverview = movieData["overview"]?.string {
                            movieModel.overview = movieOverview
                        }
                        if let movieGenres = movieData["genres"]?.array {
                            var movieGenreArray = [String]()
                            for genre in movieGenres {
                                movieGenreArray.append(genre.stringValue)
                            }
                            movieModel.genres = movieGenreArray
                        }
                        if let movieRating = movieData["rating"]?.double {
                            movieModel.rating = round(movieRating)
                        }
                        if let movieImages = movieData["images"]?.dictionary {
                            
                            if let moviePoster = movieImages["poster"]?.dictionary {
                                
                                movieModel.posterThumbnailURL = moviePoster["thumb"]?.stringValue
                                movieModel.posterFullURL = moviePoster["full"]?.stringValue
                            }
                        }
                    }
                    movies.append(movieModel)
                }
            }
        }
        return movies
    }
}
