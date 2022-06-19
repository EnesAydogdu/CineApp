//
//  SeriesViewController+TableView.swift
//  CineApp
//
//  Created by Enes Aydogdu on 13.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import UIKit
import Kingfisher
import Foundation

extension SeriesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.popularCollectionView){
            return popularSeries.count
        }
        else  {
            return topRatedSeries.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.popularCollectionView){
            guard let popularCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.popularCollectionCellId, for: indexPath) as? PopularSeriesCollectionViewCell
                else { return UICollectionViewCell() }
            let popularTvSeries = popularSeries[indexPath.row]
            let seriesPosterUrl = Constants.seriesArtworkUrl + (popularTvSeries.poster_path ?? "")
            
            if indexPath.row == 0 {
                popularSeriesGenreLabel.text = popularTvSeries.genres
                popularSeriesLabel.text = popularTvSeries.name
                popularSeriesRatingLabel.text = popularTvSeries.vote_average
            }
            popularCell.popularSeriesImageView.kf.setImage(with: URL(string: seriesPosterUrl))
            popularCell.popularSeriesImageView.layer.cornerRadius = CGFloat(Constants.ratingLabelRadius)
            popularCell.popularSeriesView.layer.cornerRadius = CGFloat(Constants.ratingLabelRadius)
            return popularCell
            
        } else {
            guard let topRatedCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.topRatedCollectionCellId, for: indexPath) as? TopRatedSeriesCollectionViewCell else { return UICollectionViewCell() }
            let topRatedTvSeries = topRatedSeries[indexPath.row]
            let topRatedPosterUrl = Constants.seriesArtworkUrl + (topRatedTvSeries.poster_path ?? "")
            
            topRatedCell.topRatedSeriesNameLabel.text = topRatedTvSeries.name
            topRatedCell.topRatedSeriesRatingLabel.text = topRatedTvSeries.vote_average
            topRatedCell.topRatedSeriesImageView.kf.setImage(with: URL(string: topRatedPosterUrl))
            topRatedCell.topRatedSeriesView.layer.cornerRadius = CGFloat(Constants.ratingLabelRadius)
            topRatedCell.topRatedSeriesImageView.layer.cornerRadius = CGFloat(Constants.ratingLabelRadius)
            return topRatedCell
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: Int(UIScreen.main.bounds.width), height: Constants.collectionCellHeight)
//    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: popularCollectionView.contentOffset, size: popularCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = popularCollectionView.indexPathForItem(at: visiblePoint)
        let popularTvSeries = popularSeries[visibleIndexPath?.row ?? 0]
        popularSeriesGenreLabel.text = popularTvSeries.genres
        popularSeriesLabel.text = popularTvSeries.name
        popularSeriesRatingLabel.text = popularTvSeries.vote_average
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == popularCollectionView.self {
            return CGSize(width: UIScreen.main.bounds.width , height: 375 )
        }
        return CGSize(width: 152 , height: 260)
    }
}




