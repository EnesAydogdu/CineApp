//
//  UserProfileViewController.swift
//  CineApp
//
//  Created by Enes Aydogdu on 10.06.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class UserProfileViewController: UIViewController {
    
    enum constants {
        static let favoriteListTableViewCellId = "FavoriteListTableViewCell"
        static let favoriteArtworkUrl = "https://image.tmdb.org/t/p/w500"
    }
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet var userProfileView: UIView!
    @IBOutlet weak var favoriteListTableView: UITableView!
    
    var favoriteMoviesUIModel: MovieUIModel?
    var favoriteSeriesUIModel: SeriesUIModel?
    var favoriteMoviesList = [MovieUIModel]()
    var favoriteSeriesList = [SeriesUIModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let retrievedUsername: String? = KeychainWrapper.standard.string(forKey: "Username")
        usernameLabel.text = retrievedUsername
        StatusBarUtil.instance.StatusBarBackgroundColor(endpoint: userProfileView, color:UIColor.greenShenColor)
        self.navigationController?.navigationBar.backgroundColor = UIColor.greenShenColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavoriteMoviesList()
        getFavoriteSeriesList()
    }
    @IBAction func logoutButtonAction(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "IsLoggedIn")
        KeychainWrapper.standard.set("Jessie Doe", forKey: "Username")
        KeychainWrapper.standard.removeObject(forKey: "AccountId")
        KeychainWrapper.standard.removeObject(forKey: "SessionId")
        usernameLabel.text = KeychainWrapper.standard.string(forKey: "Username")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func getFavoriteMoviesList() {
        TmDBService.instance.favoriteMoviesList(accountId: KeychainWrapper.standard.string(forKey: "AccountId"), sessionId: KeychainWrapper.standard.string(forKey: "SessionId"), completion: { favoriteMovies in
            self.favoriteMoviesList.removeAll()
            for favorite in favoriteMovies {
                let movieUIModel = MovieUIModel(poster_path: favorite.poster_path ?? "", id: favorite.id ?? 0, title: favorite.title ?? "" , vote_average: String(favorite.vote_average ?? 0), overview: favorite.overview ?? "", release_date: favorite.release_date ?? "", runtime: "", genres: "", backdrop_path: favorite.backdrop_path ?? "", favorite: false )
                self.favoriteMoviesList.append(movieUIModel)
            }
            DispatchQueue.main.async {
                self.favoriteListTableView.reloadData()
            }
            
        }
        )}
    
    func getFavoriteSeriesList() {
        TmDBService.instance.favoriteSeriesList(accountId: KeychainWrapper.standard.string(forKey: "AccountId"), sessionId: KeychainWrapper.standard.string(forKey: "SessionId"), completion: { favoriteSeries in
            self.favoriteSeriesList.removeAll()
            for favorite in favoriteSeries {
                let seriesUIModel = SeriesUIModel(name: favorite.name, id: favorite.id, vote_average: String(favorite.voteAverage ?? 0), poster_path: favorite.posterPath, overview: favorite.overview, number_of_episodes: "", number_of_seasons: "", genres: "", episode_run_time: "", backdrop_path: "", dates: "", favorite: false)
                self.favoriteSeriesList.append(seriesUIModel)
            }
            DispatchQueue.main.async {
                self.favoriteListTableView.reloadData()
            }
        }
        )}
    
    func markAsFavoriteMovie(id: Int) {
        TmDBService.instance.markAsFavorite(sessionId: KeychainWrapper.standard.string(forKey: "SessionId"), accountId: KeychainWrapper.standard.string(forKey: "AccountId"), media_type: "movie", media_id: id, favorite: false, completion: { response  in
            self.getFavoriteMoviesList()
        })
    }
    
    func markAsFavoriteTvShow(id: Int) {
        TmDBService.instance.markAsFavorite(sessionId: KeychainWrapper.standard.string(forKey: "SessionId"), accountId: KeychainWrapper.standard.string(forKey: "AccountId"), media_type: "tv", media_id: id, favorite: false, completion: { response  in
            self.getFavoriteSeriesList()
        })
    }
    
    @objc func favoriteMovieButtonAction(_ sender: UIButton) {
        markAsFavoriteMovie(id: sender.tag)
    }
    
    @objc func favoriteSeriesButtonAction(_ sender: UIButton) {
        markAsFavoriteTvShow(id: sender.tag)
    }
}
