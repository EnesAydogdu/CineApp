//
//  SeriesViewController.swift
//  CineApp
//
//  Created by Enes Aydogdu on 13.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import UIKit

class SeriesViewController: UIViewController {
    
    enum Constants {
        
        static let ratingLabelRadius = 10
        static let collectionCellWidth = 400
        static let collectionCellHeight = 500
        static let seriesArtworkUrl = "https://image.tmdb.org/t/p/w500"
        static let heightForRowAt = 120
        static let popularCollectionCellId = "PopularSeriesCell"
        static let topRatedCollectionCellId =  "TopRatedSeriesCollectionCell"
        static let collectionViewSections = 1
        static let scrollViewHeight = 3740
        static let scrollViewWidth = 375
        static let popularSeriesToDetailsSegueId = "PopularSeriesToDetailPageSegue"
        static let topRatedSeriesToDetailSegueId = "TopRatedSeriesToDetailPageSegue"
    }
    
    @IBOutlet weak var popularSeriesView: UIView!
    @IBOutlet weak var popularSeriesRatingLabel: UILabel!
    @IBOutlet weak var popularSeriesLabel: UILabel!
    @IBOutlet weak var popularSeriesGenreLabel: UILabel!
    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var popularSeriesRatingView: UIView!
    @IBOutlet var seriesView: UIView!
    
    
    var popularSeries = [SeriesUIModel]()
    var topRatedSeries = [SeriesUIModel]()
    var popularSeriesList = [SeriesServiceModel]()
    var topRatedSeriesList = [SeriesServiceModel]()
    var detailSeries = [SeriesDetailModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popularSeriesRatingView.layer.cornerRadius = CGFloat(Constants.ratingLabelRadius)
        getPopularTopRatedList()
        getPopularSeriesList()
        StatusBarUtil.instance.StatusBarBackgroundColor(endpoint: seriesView, color: UIColor.greenShenColor)
        self.navigationController?.navigationBar.backgroundColor = UIColor.greenShenColor
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewWillLayoutSubviews()
        scroller.contentSize = CGSize(width: Constants.scrollViewWidth , height: Constants.scrollViewHeight)
    }
    
    func getPopularSeriesList() {
        TmDBService.instance.getPopularSeries(completion: {popularSeries in
            for series in popularSeries {
                let seriesUIModel = SeriesUIModel(name: series.name, id: series.id, vote_average: String(series.voteAverage ?? 0), poster_path: series.posterPath, overview: series.overview, number_of_episodes: "", number_of_seasons: "", genres: "", episode_run_time: "", backdrop_path: "", dates: "", favorite: false)
                self.popularSeries.append(seriesUIModel)
                TmDBService.instance.getSeriesDetails(id: seriesUIModel.id ?? 0) { seriesDetail, genreModel in
                    var popularSeriesDate: String = ""
                    if let firstDate = DateFixer.getYear(enteredDate: seriesDetail.first_air_date),
                        let lastDate = DateFixer.getYear(enteredDate: seriesDetail.last_air_date) {
                        popularSeriesDate = "TV Series (" + String(firstDate) + " - " + String(lastDate) + ")"
                    }
                    seriesUIModel.dates = popularSeriesDate
                    seriesUIModel.backdrop_path = seriesDetail.backdrop_path
                    seriesUIModel.episode_run_time = seriesDetail.episode_run_time.first?.description
                    seriesUIModel.number_of_seasons = String(seriesDetail.number_of_seasons)
                    var popularSeriesGenre: String = ""
                    for (index, genre) in genreModel.genres.enumerated() {
                        if genreModel.genres.count-1 == index {
                            popularSeriesGenre += genre.name
                        } else {
                            popularSeriesGenre += genre.name + ", "
                        }
                    }
                    seriesUIModel.genres = popularSeriesGenre
                }
                DispatchQueue.main.async {
                    self.popularCollectionView.reloadData()
                }
            }
        })}
    
    func getPopularTopRatedList() {
        TmDBService.instance.getTopRatedSeries(completion: { topRatedSeries in
            for series in topRatedSeries {
                let seriesUIModel = SeriesUIModel(name: series.name, id: series.id, vote_average: String(series.voteAverage ?? 0), poster_path: series.posterPath, overview: series.overview, number_of_episodes: "", number_of_seasons: "", genres: "", episode_run_time: "", backdrop_path: "", dates: "", favorite: false)
                self.topRatedSeries.append(seriesUIModel)
                TmDBService.instance.getSeriesDetails(id: seriesUIModel.id ?? 0) { (DetailModel, SeriesGenreModel) in
                    var topRatedSeriesDate: String = ""
                    if let firstDate = DateFixer.getYear(enteredDate: DetailModel.first_air_date), let lastDate = DateFixer.getYear(enteredDate: DetailModel.last_air_date) {
                        topRatedSeriesDate = "TV Series (" + String(firstDate) + " - " + String(lastDate) + ")"
                    }
                    seriesUIModel.dates = topRatedSeriesDate
                    seriesUIModel.backdrop_path = DetailModel.backdrop_path
                    seriesUIModel.episode_run_time = DetailModel.episode_run_time.first?.description
                    seriesUIModel.number_of_seasons = String(DetailModel.number_of_seasons)
                    var genreTopRated: String = ""
                    for(index, genre) in SeriesGenreModel.genres.enumerated(){
                        if SeriesGenreModel.genres.count-1 == index {
                            genreTopRated += genre.name
                        } else{
                            genreTopRated += genre.name + ", "
                        }
                        seriesUIModel.genres = genreTopRated
                    }
                    DispatchQueue.main.async {
                        self.topRatedCollectionView.reloadData()
                    }
                }
            }
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == Constants.popularSeriesToDetailsSegueId){
            if let destination = segue.destination as?
                SeriesDetailsViewController, let index =
                popularCollectionView.indexPathsForSelectedItems?.first {
                destination.tvDetailUIModel = popularSeries[index.row]
            } }
        else if (segue.identifier == Constants.topRatedSeriesToDetailSegueId) {
            if let destination = segue.destination as?
                SeriesDetailsViewController, let index =
                topRatedCollectionView.indexPathsForSelectedItems?.first {
                destination.tvDetailUIModel = topRatedSeries[index.row]
            }
        }
    }
}
