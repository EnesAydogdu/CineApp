//
//  SeriesDetailsViewController.swift
//  CineApp
//
//  Created by Enes Aydogdu on 18.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import UIKit
import Foundation
import SwiftKeychainWrapper

class SeriesDetailsViewController: UIViewController {
    
    enum constants {
        static let seasonsLabel = " Seasons"
        static let seriesArtworkUrl = "https://image.tmdb.org/t/p/w500"
        static let minutesLabel = "Min"
        static let cornerRadius = CGFloat(10)
        static let seriesToDetailsSegueId = "SeriesToCreditsSegueId"
    }
    
    @IBOutlet weak var seriesDetailImageView: UIImageView!
    @IBOutlet weak var seriesDetailRatingLabel: UILabel!
    @IBOutlet weak var seriesDetailNameLabel: UILabel!
    @IBOutlet weak var seriesDetailGenreLabel: UILabel!
    @IBOutlet weak var seriesDetailRuntimeLabel: UILabel!
    @IBOutlet weak var seriesDetailDateLabel: UILabel!
    @IBOutlet weak var seriesDetailNumberOfSeasonsLabel: UILabel!
    @IBOutlet weak var seriesDetailRatingView: UIView!
    @IBOutlet weak var seriesDetailSeasonsView: UIView!
    @IBOutlet weak var seriesDetailOverviewTextView: UITextView!
    @IBOutlet weak var seriesDetailsCreditsCollectionView: UICollectionView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    var tvDetailUIModel: SeriesUIModel?
    var seriesCreditsList = [CreditsUIModel]()
    var seriesDirectorList = [CreditsUIModel]()
    var seriesCreditsCrewList = [CreditsServiceModel]()
    var movieId: Int?
    var seriesDetails = [SeriesUIModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.seriesDetailRatingView.layer.cornerRadius = constants.cornerRadius
        self.seriesDetailSeasonsView.layer.cornerRadius = constants.cornerRadius
        favoriteButton.layer.cornerRadius = favoriteButton.frame.height / 2
        getSeriesDetails()
        getSeriesCredits()
        getSeriesDetailsFromPeople()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrowBack"), style: .plain, target: self, action: #selector(popViewController))
        getSeriesAccountStates()
        setFavoriteButtonImage()
    }
    
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func getSeriesCredits() {
        TmDBService.instance.getSeriesCredits(id: tvDetailUIModel?.id ?? 0 , completion: { seriesCredits,crewCredits  in
            for credit in seriesCredits {
                let creditsUIModel = CreditsUIModel(cast_id: credit.cast_id ?? 0, character: credit.character ?? "", credit_id: credit.credit_id ?? "", gender: credit.gender ?? 0, id: credit.id ?? 0, name: credit.name ?? "", order: credit.order ?? 0, profile_path: credit.profile_path ?? "", department: credit.department ?? "", job: credit.job ?? "")
                self.seriesCreditsList.append(creditsUIModel)
                
                DispatchQueue.main.async {
                    self.seriesDetailsCreditsCollectionView.reloadData()
                }
            }
        })
    }
    
    func getSeriesDetailsFromPeople() {
        
        TmDBService.instance.getSeriesDetails(id: tvDetailUIModel?.id ?? 0) { seriesDetail, genreModel in
            var seriesDate: String = ""
            if let firstDate = DateFixer.getYear(enteredDate: seriesDetail.first_air_date),
                let lastDate = DateFixer.getYear(enteredDate: seriesDetail.last_air_date) {
                seriesDate = "TV Series (" + String(firstDate) + " - " + String(lastDate) + ")"
            }
            self.tvDetailUIModel?.dates = seriesDate
            self.tvDetailUIModel?.backdrop_path = seriesDetail.backdrop_path
            self.tvDetailUIModel?.episode_run_time = seriesDetail.episode_run_time.first?.description
            self.tvDetailUIModel?.number_of_seasons = String(seriesDetail.number_of_seasons)
            self.tvDetailUIModel?.overview = seriesDetail.overview ?? ""
            self.tvDetailUIModel?.vote_average = (seriesDetail.vote_average ?? 0).description
            var seriesGenre: String = ""
            for (index, genre) in genreModel.genres.enumerated() {
                if genreModel.genres.count-1 == index {
                    seriesGenre += genre.name
                } else {
                    seriesGenre += genre.name + ", "
                }
            }
            self.tvDetailUIModel?.genres = seriesGenre
        }
        DispatchQueue.main.async {
            let seriesPosterUrl = constants.seriesArtworkUrl + (self.tvDetailUIModel?.backdrop_path ?? "")
            self.seriesDetailDateLabel.text = self.tvDetailUIModel?.dates
            self.seriesDetailGenreLabel.text = self.tvDetailUIModel?.genres
            self.seriesDetailRatingLabel.text = self.tvDetailUIModel?.vote_average
            self.seriesDetailOverviewTextView.text = self.tvDetailUIModel?.overview
            self.seriesDetailNumberOfSeasonsLabel.text = (self.tvDetailUIModel?.number_of_seasons ?? "") + " " + constants.seasonsLabel
            self.seriesDetailRuntimeLabel.text = self.tvDetailUIModel?.episode_run_time ?? ""  + " " + constants.minutesLabel
            self.seriesDetailNameLabel.text = self.tvDetailUIModel?.name
            self.seriesDetailImageView.kf.setImage(with: URL(string: seriesPosterUrl))
        }
    }
    
    func getSeriesDetails() {
        let seriesPosterUrl = constants.seriesArtworkUrl + (tvDetailUIModel?.backdrop_path ?? "")
        seriesDetailNameLabel.text = tvDetailUIModel?.name
        seriesDetailDateLabel.text = tvDetailUIModel?.dates
        seriesDetailGenreLabel.text = tvDetailUIModel?.genres
        seriesDetailRatingLabel.text = tvDetailUIModel?.vote_average
        seriesDetailOverviewTextView.text = tvDetailUIModel?.overview
        seriesDetailNumberOfSeasonsLabel.text = (tvDetailUIModel?.number_of_seasons ?? "") + " " + constants.seasonsLabel
        seriesDetailRuntimeLabel.text = tvDetailUIModel?.episode_run_time ?? ""  + " " + constants.minutesLabel
        seriesDetailImageView.kf.setImage(with: URL(string: seriesPosterUrl))
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == constants.seriesToDetailsSegueId){
            if let destination = segue.destination as?
                CreditsViewController, let index =
                seriesDetailsCreditsCollectionView.indexPathsForSelectedItems?.first {
                destination.id = seriesCreditsList[index.row].id
            }
        }
    }
    
    func markAsFavorite() {
        TmDBService.instance.markAsFavorite(sessionId: KeychainWrapper.standard.string(forKey: "SessionId"), accountId: KeychainWrapper.standard.string(forKey: "AccountId"), media_type: "tv", media_id: tvDetailUIModel?.id, favorite: !tvDetailUIModel!.favorite!, completion: { response  in
            if let favorite = self.tvDetailUIModel?.favorite{
                self.tvDetailUIModel?.favorite = !favorite
            }
            DispatchQueue.main.async {
                self.setFavoriteButtonImage()
            }
        })
    }
    
    func getSeriesAccountStates() {
        TmDBService.instance.getSeriesAccountStates(accountId: KeychainWrapper.standard.string(forKey: "AccountId"), sessionId: KeychainWrapper.standard.string(forKey: "SessionId"), mediaId: tvDetailUIModel?.id, completion: { accountState in
            self.tvDetailUIModel?.favorite = accountState.favorite
    })
    }
    @IBAction func markAsFavAction(_ sender: Any) {
        markAsFavorite()
    }
    
    func setFavoriteButtonImage() {
        if self.tvDetailUIModel?.favorite == true {
            self.favoriteButton.setImage(UIImage(named: "heart2"), for: .normal)
        } else {
            self.favoriteButton.setImage(UIImage(named: "heart"), for: .normal)
        }
    }
    
}
