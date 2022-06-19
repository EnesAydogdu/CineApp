//
//  MoviesViewController+CollectionView.swift
//  CineApp
//
//  Created by Enes Aydogdu on 6.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import UIKit
import Kingfisher
import Foundation

extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlayingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let nowPlayingCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewCellId, for: indexPath) as? MoveeCollectionCell
            else { return UICollectionViewCell() }
        let nowPlayingMovie = nowPlayingMovies[indexPath.row]
        let moviePosterUrl = Constants.movieArtworkUrl + (nowPlayingMovie.poster_path ?? "")
        
        if indexPath.row == 0 {
            genreLabel.text = nowPlayingMovie.genres
            movieNameLabel.text = nowPlayingMovie.title
            ratingLabel.text = nowPlayingMovie.vote_average
        }
        nowPlayingCell.mainMovieArtworkImageView.kf.setImage(with: URL(string: moviePosterUrl))
        nowPlayingCell.mainMovieArtworkImageView.layer.cornerRadius = CGFloat(Constants.ratingLabelRadius)
        return nowPlayingCell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: nowPlayingCollectionView.contentOffset, size: nowPlayingCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = nowPlayingCollectionView.indexPathForItem(at: visiblePoint)
        let visibleRowIndex = visibleIndexPath?.row ?? 0
        if nowPlayingMovies.count > visibleRowIndex {
            let nowPlayingMovie = nowPlayingMovies[visibleRowIndex]
            genreLabel.text = nowPlayingMovie.genres
            movieNameLabel.text = nowPlayingMovie.title
            ratingLabel.text = nowPlayingMovie.vote_average
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == nowPlayingCollectionView.self {
            return CGSize(width: UIScreen.main.bounds.width , height: 373 )
        }
        
        return CGSize(width: 152 , height: 260)
    }
}
