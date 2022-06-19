//
//  FavoriteListTableView.swift
//  CineApp
//
//  Created by Enes Aydogdu on 20.06.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import UIKit

extension UserProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return favoriteMoviesList.count
        } else if section == 1 {
            return favoriteSeriesList.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let favoriteMoviesListCell = favoriteListTableView.dequeueReusableCell(withIdentifier: constants.favoriteListTableViewCellId) as? FavoriteListTableViewCell else { return UITableViewCell() }
            
            let favoriteMovie = favoriteMoviesList[indexPath.row]
            let moviePosterUrl = constants.favoriteArtworkUrl + (favoriteMovie.poster_path ?? "")
            favoriteMoviesListCell.favoriteListNameLabel.text = favoriteMovie.title
            favoriteMoviesListCell.favoriteListImageView.kf.setImage(with: URL(string: moviePosterUrl))
            favoriteMoviesListCell.favoriteButton.tag = favoriteMovie.id ?? 0
            favoriteMoviesListCell.favoriteButton.addTarget(self, action: #selector(favoriteMovieButtonAction), for: UIControl.Event.touchUpInside)
            
            return favoriteMoviesListCell
        } else if indexPath.section == 1 {
            guard let favoriteSeriesListCell = favoriteListTableView.dequeueReusableCell(withIdentifier: constants.favoriteListTableViewCellId) as? FavoriteListTableViewCell else { return UITableViewCell() }
            
            let favoriteSeries = favoriteSeriesList[indexPath.row]
            let moviePosterUrl = constants.favoriteArtworkUrl + (favoriteSeries.poster_path ?? "")
            favoriteSeriesListCell.favoriteListNameLabel.text = favoriteSeries.name
            favoriteSeriesListCell.favoriteListImageView.kf.setImage(with: URL(string: moviePosterUrl))
            favoriteSeriesListCell.favoriteButton.tag = favoriteSeries.id ?? 0
            favoriteSeriesListCell.favoriteButton.addTarget(self, action: #selector(favoriteSeriesButtonAction), for: UIControl.Event.touchUpInside)
            
            return favoriteSeriesListCell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if self.tableView(tableView, numberOfRowsInSection: section) == 0 {
            return nil
        }
        if section == 0 {
            return ("Movies")
        } else if section == 1 {
            return ("Tv Series")
        } else {
            return ""
        }
    }
}
