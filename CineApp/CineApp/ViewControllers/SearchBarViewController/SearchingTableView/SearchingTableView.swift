//
//  SearchingTableView.swift
//  CineApp
//
//  Created by Enes Aydogdu on 4.06.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation
import UIKit

extension SearchingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        guard let text = navigationItem.searchController?.searchBar.text else { return 0 }
        if !text.isEmpty && searching.count == 0 && text.count > 3 {
            tableView.backgroundView  = noResultsView
            tableView.separatorStyle  = .none
            tableView.backgroundView?.isHidden = false
            noResultsView.isHidden = false
            
        } else {
            tableView.backgroundView?.isHidden = true
            tableView.separatorStyle = .none
            numOfSections = 1
            noResultsView.isHidden = true
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if navigationController?.navigationItem.searchController?.searchBar.text != "" {
            return searching.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if searching.isEmpty {
            return UITableViewCell()
        }
        if (searching[indexPath.row].mediaType == "movie") {
            guard let moviesSearchingCell = searchingTableView.dequeueReusableCell(withIdentifier: constants.moviesSearchingTableViewCell) as? MoviesSearchingTableViewCell else { return UITableViewCell() }
            
            let movieSearch = searching[indexPath.row]
            let moviesPosterUrl = constants.artworkUrl + String(movieSearch.posterPath ?? "")
            
            if moviesPosterUrl == constants.artworkUrl {
                moviesSearchingCell.moviesSearchingImageView.image = UIImage(systemName: "questionmark")
            } else {
                moviesSearchingCell.moviesSearchingImageView.kf.setImage(with: URL(string: moviesPosterUrl))
            }
            moviesSearchingCell.moviesSearchingNameLabel.text = movieSearch.title
            moviesSearchingCell.moviesSearchingTypeLabel.text = movieSearch.mediaType
            moviesSearchingCell.moviesSearchingPeopleLabel.text = movieSearch.cast
            return moviesSearchingCell
            
        } else if (searching[indexPath.row].mediaType == "tv") {
            guard let seriesSearchingCell = searchingTableView.dequeueReusableCell(withIdentifier: constants.seriesSearchingTableViewCell) as? SeriesSearchingTableViewCell else { return UITableViewCell() }
            
            let seriesSearch = searching[indexPath.row]
            let seriesPosterUrl = constants.artworkUrl + String(seriesSearch.posterPath ?? "")
            if seriesPosterUrl == constants.artworkUrl {
                seriesSearchingCell.seriesSearchingImageView.image = UIImage(systemName: "questionmark")
            } else {
                seriesSearchingCell.seriesSearchingImageView.kf.setImage(with: URL(string: seriesPosterUrl))
            }
            seriesSearchingCell.seriesSearchingNameLabel.text = seriesSearch.name
            seriesSearchingCell.seriesSearchingTypeLabel.text = seriesSearch.mediaType
            seriesSearchingCell.seriesSearchingPeopleLabel.text = seriesSearch.cast
            
            return seriesSearchingCell
            
        } else {
            guard let peopleSearchingCell = searchingTableView.dequeueReusableCell(withIdentifier: constants.peopleSearchingTableViewCell) as? PeopleSearchingTableViewCell else { return UITableViewCell() }
            
            let peopleSearch = searching[indexPath.row]
            let peoplePosterUrl = constants.artworkUrl + String(peopleSearch.profilePath ?? "")
            if peoplePosterUrl == constants.artworkUrl {
                peopleSearchingCell.peopleSearchingImageView.image = UIImage(systemName: "questionmark")
            } else {
                peopleSearchingCell.peopleSearchingImageView.kf.setImage(with: URL(string: peoplePosterUrl))
            }
            peopleSearchingCell.peopleSearchingNameLabel.text = peopleSearch.name
            peopleSearchingCell.peopleSearchingTypeLabel.text = peopleSearch.mediaType
            
            return peopleSearchingCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchingList = searching[indexPath.row]
        guard let searchingId = searchingList.id else { return }
        if searchingList.mediaType == constants.tvMediaType {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let seriesDetailsViewController = storyboard.instantiateViewController(identifier: constants.seriesDetailsViewControllerId)  as? SeriesDetailsViewController else { return }
            
            let uiModel = SeriesUIModel(id: searchingId)
            seriesDetailsViewController.tvDetailUIModel = uiModel
            navigationController?.pushViewController(seriesDetailsViewController, animated: true)
        }
        else if searchingList.mediaType == constants.movieMediaType {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let movieDetailsViewController = storyboard.instantiateViewController(identifier: constants.movieDetailsViewControllerId) as? MovieDetailsViewController else { return }
            
            let uiModel = MovieUIModel(id: searchingId)
            movieDetailsViewController.movieDetailsUIModel = uiModel
            navigationController?.pushViewController(movieDetailsViewController, animated: true)
        }
        else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let creditsViewController = storyboard.instantiateViewController(identifier: constants.personDetailsViewControllerId)  as? CreditsViewController else { return }
            
            let uiModel = CreditsDetailsUIModel(id: searchingId)
            creditsViewController.id = uiModel.id
            navigationController?.pushViewController(creditsViewController, animated: true)
        }
    }
}
