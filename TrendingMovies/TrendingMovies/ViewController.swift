//
//  ViewController.swift
//  TrendingMovies
//
//  Created by Marcin on 03/09/2016.
//  Copyright © 2016 MarcinSteciuk. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var trendingMovieService: TrendingMoviesService?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TrendingMoviesService().getTrendingMovies()
    }
}

