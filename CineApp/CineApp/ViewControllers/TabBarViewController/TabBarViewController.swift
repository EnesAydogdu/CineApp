//
//  TabBarViewController.swift
//  CineApp
//
//  Created by Enes Aydogdu on 13.06.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    @IBOutlet weak var mainTabBar: UITabBar!
    
    enum Constants {
        static let seriesTabBar = "iconsTabbarSerie"
        static let moviesTabBar = "moviesTabBar"
        static let selectedSeriesTabBar = "seriesTabBar"
        static let selectedMoviesTabBar = "movies"
        static let userTabBar = "iconsTabbarProfil"
        static let userSelectedTabBar = "iconsTabbarProfilSelected"
        static let searchTabBar = "iconsTabbarSearch"
        static let searchSelectedTabBar = "iconsTabbarSearchSelected"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true

        getTabItem()
    }

    func getTabItem() {
        let imageSeries : UIImage? = UIImage.init(named: Constants.seriesTabBar)!.withRenderingMode(.alwaysOriginal)
        let imageMovies : UIImage? = UIImage.init(named: Constants.moviesTabBar)!.withRenderingMode(.alwaysOriginal)
        let imageSeriesSelected : UIImage? = UIImage.init(named: Constants.selectedSeriesTabBar)!.withRenderingMode(.alwaysOriginal)
        let imageMoviesSelected : UIImage? = UIImage.init(named: Constants.selectedMoviesTabBar)!.withRenderingMode(.alwaysOriginal)
        self.mainTabBar.items?[0].image = imageMovies
        self.mainTabBar.items?[1].image = imageSeries
        self.mainTabBar.items?[1].selectedImage = imageSeriesSelected
        self.mainTabBar.items?[0].selectedImage = imageMoviesSelected
        let imageSearch : UIImage? = UIImage.init(named: Constants.searchTabBar)!.withRenderingMode(.alwaysOriginal)
        let imageProfile : UIImage? = UIImage.init(named: Constants.userTabBar)!.withRenderingMode(.alwaysOriginal)
        let imageSelectedProfile : UIImage? = UIImage.init(named: Constants.userSelectedTabBar)!.withRenderingMode(.alwaysOriginal)
        let imageSearchSelected : UIImage? = UIImage.init(named: Constants.searchSelectedTabBar)!.withRenderingMode(.alwaysOriginal)
        self.mainTabBar.items?[2].image = imageSearch
        self.mainTabBar.items?[3].image = imageProfile
        self.mainTabBar.items?[3].selectedImage = imageSelectedProfile
        self.mainTabBar.items?[2].selectedImage = imageSearchSelected
    }
}
