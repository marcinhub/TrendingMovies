//
//  ViewController.swift
//  TrendingMovies
//
//  Created by Marcin on 03/09/2016.
//  Copyright © 2016 MarcinSteciuk. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class MovieListViewController: UIViewController {
    
    var trendingMovieService: TrendingMoviesService?
    var movies: [Movie]?

    @IBOutlet weak var tableVIew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.navigationItem.title = "Trending Movies";
        
        TrendingMoviesService().getTrendingMovies() { (movies) in
            
            print(movies)
            self.movies = movies
            
            dispatch_async(dispatch_get_main_queue()) {
                
                self.tableVIew.reloadData()
            }
        }
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let moviesCount = movies?.count else {
            return 0
        }
        
        return moviesCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MovieCell
        
        if let movies = self.movies {
            let movie = movies[indexPath.row]
            
            movieCell.movieTitleLabel?.text = movie.title
            
            guard let moviePosterURL = movie.posterThumbnailURL, imageURL = NSURL(string: moviePosterURL) else {
                
                return movieCell
            }
            
            movieCell.posterThumbnailImageView?.sd_setImageWithURL(imageURL)
        }
        
        return movieCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if let movies = self.movies {
            let movie = movies[indexPath.row]
            
            let movieDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MovieDetailViewController") as! MovieDetailViewController
            
            movieDetailViewController.movie = movie
            
            self.navigationController?.pushViewController(movieDetailViewController, animated: true)
        }
    }
}

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var posterThumbnailImageView: UIImageView!
}
