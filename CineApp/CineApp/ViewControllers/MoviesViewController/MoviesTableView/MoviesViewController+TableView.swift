//
//  MoviesViewController+TableCell.swift
//  CineApp
//
//  Created by Enes Aydogdu on 5.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension MoviesViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let popularCell = popularTableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellId) as? MoveeTableCell else { return UITableViewCell() }
        
        let popularMovie = popularMovies[indexPath.row]
        let moviePosterUrl = Constants.movieArtworkUrl + String(popularMovie.poster_path ?? "")
        
        popularCell.tableGenreLabel.text = popularMovie.genres
        popularCell.tableMovieNameLabel.text = popularMovie.title
        popularCell.tableMovieRatingLabel.text = String(popularMovie.vote_average ?? "")
        popularCell.tableMovieDateLabel.text = popularMovie.release_date
        popularCell.tableMovieImageView.kf.setImage(with: URL(string: moviePosterUrl))
        popularCell.tableMovieTimeLabel.text = popularMovie.runtime
        
        popularCell.tableMovieRatingView.layer.cornerRadius = CGFloat(Constants.ratingLabelRadius)
        popularCell.viewOfCell.layer.cornerRadius = CGFloat(Constants.ratingLabelRadius)
        popularCell.tableMovieImageView.layer.cornerRadius = CGFloat(Constants.ratingLabelRadius)
        return popularCell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (popularMovies.count)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Constants.heightForRowAt)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.tableViewSections
    }
    
}
