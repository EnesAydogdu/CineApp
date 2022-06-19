//
//  SeriesDetailsCreditsCollectionView.swift
//  CineApp
//
//  Created by Enes Aydogdu on 26.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation
import UIKit

extension SeriesDetailsViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seriesCreditsList.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        guard let seriesCreditCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeriesDetailsCreditsCollectionViewCell", for: indexPath) as? SeriesDetailsCreditsCollectionViewCell
        else { return UICollectionViewCell() }
        let seriesCredits = seriesCreditsList[indexPath.row]
        let seriesCreditsPosterUrl = constants.seriesArtworkUrl + seriesCredits.profile_path
        seriesCreditCell.seriesDetailsCreditsImageView.kf.setImage(with: URL(string: seriesCreditsPosterUrl))
        seriesCreditCell.seriesDetailsCreditsNameLabel.text = seriesCredits.name
        seriesCreditCell.seriesDetailsCreditsImageView.layer.cornerRadius = seriesCreditCell.seriesDetailsCreditsImageView.frame.size.width / 2
        seriesCreditCell.seriesDetailsCreditsImageView.clipsToBounds = true
        return seriesCreditCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 100.0)
    }
}
