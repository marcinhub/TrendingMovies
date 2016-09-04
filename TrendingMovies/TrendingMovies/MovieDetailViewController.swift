//
//  MovieDetailViewController.swift
//
//
//  Created by Marcin on 04/09/2016.
//
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {
    
    var movie: Movie?
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = self.movie{
            
            if let moviePosterURL = movie.posterFullURL, imageURL = NSURL(string: moviePosterURL) {
                
                posterImageView.sd_setImageWithURL(imageURL)

            }
            if let genres = movie.genres {
                let joiner = "\n"
                let genresString = genres.joinWithSeparator(joiner)
                genresLabel.text = genresString
            }
            titleLabel.text = movie.title
            
            if let rating = movie.rating {
                
                ratingLabel.text = "Rating: " + String(rating)

            }
            overviewLabel.text = movie.overview
        }

        
       
        
    }
}
