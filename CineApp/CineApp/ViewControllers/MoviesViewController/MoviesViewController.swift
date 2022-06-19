//
//  MoviesViewController.swift
//  CineApp
//
//  Created by Enes Aydogdu on 31.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//
import Foundation
import UIKit
import MapKit

class MoviesViewController: BaseViewController {

    enum Constants {
        static let ratingLabelRadius = 10
        static let collectionCellWidth = 400
        static let collectionCellHeight = 500
        static let movieArtworkUrl = "https://image.tmdb.org/t/p/w500"
        static let heightForRowAt = 120
        static let tableViewCellId = "PopularMoviesCell"
        static let collectionViewCellId = "MainMoviesImageCell"
        static let tableViewSections = 1
        static let seriesTabBar = "seriesTabBar"
        static let moviesTabBar = "moviesTabBar"
        static let popularMoviesToDetailPageSegueId = "PopularMoviesToDetailsPageSegue"
        static let nowPlayingMoviesToDetailPageSegueId = "NowPlayingMoviesToDetailsPageSegue"
    }

    @IBOutlet weak var popularTableView: UITableView!
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabelView: UIView!
    @IBOutlet weak var moviesView: UIView!
    @IBOutlet weak var mapKitView: MKMapView!
    
    var model: MoviesDomainModel!
    let layout = UICollectionViewFlowLayout()
    var popularMovies = [MovieUIModel]()
    var nowPlayingMovies = [MovieUIModel]()
    var moviePopularList = [MovieServiceModel]()
    var nowPlayingList = [MovieServiceModel]()
    var detailPopular = [MovieDetailsModel]()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        model = MoviesDomainModel(delegate: self)
        model.getPopularMoviesList()
        model.getNowPlayingMoviesList()
        self.ratingLabelView.layer.cornerRadius = CGFloat(Constants.ratingLabelRadius)
        StatusBarUtil.instance.StatusBarBackgroundColor(endpoint: moviesView, color: UIColor.greenShenColor)
        navigationController?.navigationBar.backgroundColor = UIColor.greenShenColor
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == Constants.popularMoviesToDetailPageSegueId){
            if let destination = segue.destination as?
                MovieDetailsViewController, let index =
                popularTableView.indexPathsForSelectedRows?.first {
                destination.movieDetailsUIModel = popularMovies[index.row]
            }
        }
        else if (segue.identifier == Constants.nowPlayingMoviesToDetailPageSegueId) {
            if let destination = segue.destination as?
                MovieDetailsViewController, let index =
                nowPlayingCollectionView.indexPathsForSelectedItems?.first {
                destination.movieDetailsUIModel = nowPlayingMovies[index.row]
            }
        }
    }
}



extension MoviesViewController: MoviesDomainModelDelegate {
    func fetchedPopularMoviesList(popularMoviesList: [MovieUIModel]) {
        self.popularMovies = popularMoviesList
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.popularTableView.reloadData()
        }
    }
    
    func fetchedNowPlayingMoviesList(nowplayingMoviesList: [MovieUIModel]) {
        self.nowPlayingMovies = nowplayingMoviesList
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.nowPlayingCollectionView.reloadData()
        }
    }
}
