//
//  MovieDetailsViewController.swift
//  CineApp
//
//  Created by Enes Aydogdu on 20.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class MovieDetailsViewController: UIViewController {
    
    enum constants {
        static let moviesArtworkUrl = "https://image.tmdb.org/t/p/w500"
        static let minutesLabel = "Min"
        static let cornerRadius = CGFloat(10)
        static let moviesToCreditsSegueId = "MoviesToCreditsSegueId"
    }
    
    @IBOutlet weak var movieDetailsImageView: UIImageView!
    @IBOutlet weak var movieDetailsRatingLabel: UILabel!
    @IBOutlet weak var movieDetailsNameLabel: UILabel!
    @IBOutlet weak var movieDetailsGenreLabel: UILabel!
    @IBOutlet weak var movieDetailsRuntimeLabel: UILabel!
    @IBOutlet weak var movieDetailsDateLabel: UILabel!
    @IBOutlet weak var movieDetailsOverviewLabel: UITextView!
    @IBOutlet weak var movieDetailsRatingView: UIView!
    @IBOutlet weak var moviesCreditsCollectionView: UICollectionView!
    @IBOutlet weak var movieDetailsCreatorsLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var movieDetailsUIModel: MovieUIModel?
    var moviesCredits: CreditsModel?
    var creditsList = [CreditsUIModel]()
    var directorList = [CreditsUIModel]()
    var creditsCrewList = [CreditsServiceModel]()
    var isButtonStatus: Bool = false
    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        markAsFavorite()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.movieDetailsRatingView.layer.cornerRadius = constants.cornerRadius
        getMovieCredits()
        getMovieDetails()
        getMoviesDetailsFromPeople()
        favoriteButton.layer.cornerRadius = favoriteButton.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrowBack"), style: .plain, target: self, action: #selector(popViewController))
        getMovieAccountStates()
        setFavoriteButtonImage()
    }
    
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func getMovieCredits() {
        guard let movieId = movieDetailsUIModel?.id else { return }
        
        TmDBService.instance.getMoviesCredits(id: movieId, completion: { movieCredits,crewCredits  in
            for credit in movieCredits {
                let creditsUIModel = CreditsUIModel(cast_id: credit.cast_id ?? 0, character: credit.character ?? "", credit_id: credit.credit_id ?? "", gender: credit.gender ?? 0, id: credit.id ?? 0, name: credit.name ?? "", order: credit.order ?? 0, profile_path: credit.profile_path ?? "", department: credit.department ?? "", job: credit.job ?? "")
                self.creditsList.append(creditsUIModel)
                
                DispatchQueue.main.async {
                    self.moviesCreditsCollectionView.reloadData()
                }
            }
            
            let directors = crewCredits.filter ({ $0.job == "Director" })
            var directorNameList = [String]()
            
            for director in directors {
                directorNameList.append(director.name ?? "")
                DispatchQueue.main.async {
                    self.movieDetailsCreatorsLabel.text = directorNameList.reduce("", { $0 == "" ? $1 : $0 + "," + $1 })
                }
            }
        })
    }
    
    func getMoviesDetailsFromPeople() {
        
        TmDBService.instance.getMovieDetail(id: movieDetailsUIModel!.id ?? 0) { moviesDetail in
            self.movieDetailsUIModel?.release_date = moviesDetail.release_date
            self.movieDetailsUIModel?.backdrop_path = moviesDetail.backdrop_path ?? ""
            self.movieDetailsUIModel?.runtime = moviesDetail.runtime.description
            self.movieDetailsUIModel?.overview = moviesDetail.overview
            self.movieDetailsUIModel?.vote_average = (moviesDetail.vote_average).description
            self.movieDetailsUIModel?.title = moviesDetail.title
            
            var movieGenre: String = ""
            for (index, genre) in moviesDetail.genres.enumerated() {
                if moviesDetail.genres.count-1 == index {
                    movieGenre += genre.name
                } else {
                    movieGenre += genre.name + ", "
                }
            }
            self.movieDetailsUIModel?.genres = movieGenre
        }
        DispatchQueue.main.async {
            let moviesArtworkUrl = constants.moviesArtworkUrl + (self.movieDetailsUIModel?.backdrop_path ?? "")
            self.movieDetailsNameLabel.text = self.movieDetailsUIModel?.title
            self.movieDetailsRatingLabel.text = self.movieDetailsUIModel?.vote_average
            self.movieDetailsGenreLabel.text = self.movieDetailsUIModel?.genres
            self.movieDetailsRuntimeLabel.text = (self.movieDetailsUIModel?.runtime ?? "") + "" + constants.minutesLabel
            self.movieDetailsOverviewLabel.text = self.movieDetailsUIModel?.overview
            self.movieDetailsDateLabel.text = self.movieDetailsUIModel?.release_date
            self.movieDetailsImageView.kf.setImage(with: URL(string: moviesArtworkUrl))
        }
    }
    
    func getMovieDetails() {
        let moviesArtworkUrl = constants.moviesArtworkUrl + (movieDetailsUIModel?.backdrop_path ?? "")
        movieDetailsNameLabel.text = movieDetailsUIModel?.title
        movieDetailsRatingLabel.text = movieDetailsUIModel?.vote_average
        movieDetailsGenreLabel.text = movieDetailsUIModel?.genres
        movieDetailsRuntimeLabel.text = (movieDetailsUIModel?.runtime ?? "") + "" + constants.minutesLabel
        movieDetailsOverviewLabel.text = movieDetailsUIModel?.overview
        movieDetailsDateLabel.text = movieDetailsUIModel?.release_date
        movieDetailsImageView.kf.setImage(with: URL(string: moviesArtworkUrl))
    }
    
    func markAsFavorite() {
        TmDBService.instance.markAsFavorite(sessionId: KeychainWrapper.standard.string(forKey: "SessionId"), accountId: KeychainWrapper.standard.string(forKey: "AccountId"), media_type: "movie", media_id: movieDetailsUIModel?.id, favorite: !(movieDetailsUIModel?.favorite ?? false), completion: { response  in
            if let favorite = self.movieDetailsUIModel?.favorite{
                self.movieDetailsUIModel?.favorite = !favorite
            }
            DispatchQueue.main.async {
                self.setFavoriteButtonImage()
            }
        })
    }
    
    func getMovieAccountStates() {
        TmDBService.instance.getMovieAccountStates(accountId: KeychainWrapper.standard.string(forKey: "AccountId"), sessionId: KeychainWrapper.standard.string(forKey: "SessionId"), mediaId: movieDetailsUIModel?.id, completion: { accountState in
            self.movieDetailsUIModel?.favorite = accountState.favorite
        })
    }
    
    func setFavoriteButtonImage() {
        if self.movieDetailsUIModel?.favorite == true {
            self.favoriteButton.setImage(UIImage(named: "heart2"), for: .normal)
        } else {
            self.favoriteButton.setImage(UIImage(named: "heart"), for: .normal)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == constants.moviesToCreditsSegueId ){
            if let destination = segue.destination as?
                CreditsViewController, let index =
                moviesCreditsCollectionView.indexPathsForSelectedItems?.first {
                destination.id = creditsList[index.row].id
            }
        }
    }
}
