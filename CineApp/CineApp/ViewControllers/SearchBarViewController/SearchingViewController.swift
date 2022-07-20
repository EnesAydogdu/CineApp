//
//  SearchingViewController.swift
//  CineApp
//
//  Created by Enes Aydogdu on 4.06.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import UIKit
import Foundation



class SearchingViewController: UIViewController {
    
    enum constants {
        static let searchingTableViewCellId = "SearchingTableViewCell"
        static let artworkUrl = "https://image.tmdb.org/t/p/w500"
        static let seriesSearchingTableViewCell = "SeriesSearchingTableViewCell"
        static let moviesSearchingTableViewCell = "MoviesSearchingTableViewCell"
        static let peopleSearchingTableViewCell = "PeopleSearchingTableViewCell"
        static let tvMediaType = "tv"
        static let movieMediaType = "movie"
        static let personMediaType = "person"
        static let seriesDetailsViewControllerId = "SeriesDetailsViewController"
        static let movieDetailsViewControllerId = "MovieDetailsViewController"
        static let personDetailsViewControllerId = "CreditsViewController"
        static let searchTabBarIconSelected = "iconsTabbarSearchSelected"
        static let searchTabBarIcon = "iconsTabbarSearch"
    }
    
    @IBOutlet weak var searchingTableView: UITableView!
    @IBOutlet weak var noResultsView: NoResultsBackgroundView!
    var searching = [SearchingUIModel]()
    var movieCredits = [CreditsUIModel]()
    var movieId: MovieUIModel?
    let seriesId: SeriesUIModel? = nil
    let creditsId: CreditsDetailsUIModel? = nil
    @IBOutlet var searchView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StatusBarUtil.instance.StatusBarBackgroundColor(endpoint: searchView, color: UIColor.greenShenColor)
        
        createSearchBar()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarUtil()
        self.registerForKeyboardNotifications()
        self.navigationController?.navigationBar.backgroundColor = UIColor.greenShenColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.deregisterFromKeyboardNotifications()
        
    }
    
    
    func tabBarUtil() {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func createSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.barTintColor = .white
        searchController.definesPresentationContext = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.backgroundColor = UIColor.white
        searchController.searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.placeholder = "Movies or Series"
    }
    
    @objc func getSearchingPage() {
        TmDBService.instance.getSearching(query: navigationItem.searchController?.searchBar.text ?? "" , completion: { searching  in
            self.searching.removeAll()
            for search in searching {
                let searchingUIModel = SearchingUIModel(posterPath: search.poster_path, id: search.id, backdropPath: search.backdrop_path, mediaType: search.media_type, name: search.name, title: search.title, profile_path: search.profile_path, cast: "")
                
                TmDBService.instance.getMoviesCredits(id: search.id ?? 0) { (movieCast, movieCrew) in
                    var castList = [String]()
                    var moviesCast = ""
                    for cast in movieCast {
                        castList.append(cast.name ?? "")
                        moviesCast = castList.joined(separator: ", ")
                        
                        searchingUIModel.cast = moviesCast
                    }
                }
                TmDBService.instance.getSeriesCredits(id: search.id ?? 0) { (seriesCast, seriesCrew) in
                    var seriesCastList = [String]()
                    var tvCast = ""
                    for cast in seriesCast {
                        seriesCastList.append(cast.name ?? "")
                        tvCast = seriesCastList.joined(separator: ", ")
                        
                        searchingUIModel.cast = tvCast
                    }
                }
                self.searching.append(searchingUIModel)
            }
            DispatchQueue.main.async() {
                self.searchingTableView.reloadData()
            }
        })
    }
    
    func registerForKeyboardNotifications ()-> Void   {
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func deregisterFromKeyboardNotifications () -> Void {
        let center:  NotificationCenter = NotificationCenter.default
        center.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
        center.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.searchingTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            UIView.animate(withDuration: 0.25) {
                self.searchingTableView.layoutIfNeeded()
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification) {
        
        self.searchingTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        UIView.animate(withDuration: 0.5) {
            self.searchingTableView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }
    }
}

extension SearchingViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text.count >= 3 {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(getSearchingPage), object: nil)
            self.perform(#selector(getSearchingPage), with: nil, afterDelay: 0.5)
            //            getSearchingPage()
        } else {
            self.searching = []
            DispatchQueue.main.async {
                self.searchingTableView.reloadData()
            }
        }
    }
    
}
extension SearchingViewController: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let emptySearchResults = [Any]()
        searching = emptySearchResults as! [SearchingUIModel]
        searchBar.showsCancelButton = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
}
