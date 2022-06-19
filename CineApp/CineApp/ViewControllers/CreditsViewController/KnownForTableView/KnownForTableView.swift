//
//  KnownForTableView.swift
//  CineApp
//
//  Created by Enes Aydogdu on 27.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation
import UIKit

extension CreditsViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let knownForCell = creditsKnownForTableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellId) as? KnownForTableViewCell else { return UITableViewCell() }
        
        let knownForList = creditsKnownForList[indexPath.row]
        let moviePosterUrl = Constants.creditsArtworkUrl + knownForList.poster_path
        let firstDate = DateFixer.getYear(enteredDate: knownForList.release_date)
        knownForCell.creditsKnownForCharacterLabel.text = knownForList.character
        knownForCell.creditsKnownForDateLabel.text = firstDate?.description
        knownForCell.creditsKnownForMovieNameLabel.text = knownForList.title
        knownForCell.creditsKnownForImageView.kf.setImage(with: URL(string: moviePosterUrl))

        knownForCell.creditsKnownForView.layer.borderWidth = CGFloat(Constants.borderWidth)
        knownForCell.creditsKnownForView.layer.borderColor = UIColor.champagneColor.cgColor
        knownForCell.creditsKnownForView.layer.cornerRadius = CGFloat(Constants.cornerRadius)
        
        return knownForCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditsKnownForList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Constants.rowHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let knownForList = creditsKnownForList[indexPath.row]
        guard let knownForId = knownForList.id else { return }
        if knownForList.media_type == Constants.tvMediaType {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            guard let seriesDetailsViewController = storyBoard.instantiateViewController(identifier: Constants.seriesDetailsViewControllerId)  as? SeriesDetailsViewController else { return }
            
            let uiModel = SeriesUIModel(id: knownForId)
            seriesDetailsViewController.tvDetailUIModel = uiModel
            navigationController?.pushViewController(seriesDetailsViewController, animated: true)
        }
        else {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            guard let moviesDetailsViewController = storyBoard.instantiateViewController(identifier: Constants.movieDetailsViewControllerId) as? MovieDetailsViewController else { return }
            
            let uiModel = MovieUIModel(id: knownForId)
            moviesDetailsViewController.movieDetailsUIModel = uiModel
            navigationController?.pushViewController(moviesDetailsViewController, animated: true)
        }
    }
}
