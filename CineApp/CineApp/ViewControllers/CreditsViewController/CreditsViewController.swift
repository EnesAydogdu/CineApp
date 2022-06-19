//
//  CreditsViewController.swift
//  CineApp
//
//  Created by Enes Aydogdu on 27.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {
    
    enum Constants {
        static let creditsArtworkUrl = "https://image.tmdb.org/t/p/w500"
        static let tableViewCellId = "KnownForTableViewCell"
        static let rowHeight = 120
        static let heightForHeader = CGFloat(600)
        static let tvMediaType = "tv"
        static let movieMediaType = "movie"
        static let seriesDetailsViewControllerId = "SeriesDetailsViewController"
        static let movieDetailsViewControllerId = "MovieDetailsViewController"
        static let borderWidth = 1
        static let cornerRadius = 10
    }
    
    @IBOutlet weak var creditsKnownForTableView: UITableView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerNameLabel: UILabel!
    @IBOutlet weak var headerSeeFullBioButton: UIButton!
    @IBOutlet weak var headerBirthLabel: UILabel!
    @IBOutlet weak var headerBioLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet var creditsView: UIView!
    
    @IBAction func headerSeeFullBioAction(_ sender: Any) {
        if headerBioLabel.numberOfLines == 4 {
            headerBioLabel.numberOfLines = 0
            headerSeeFullBioButton.setTitle("See Less Bio", for: .normal)
            headerView.frame.size.height += contentHeight.first ?? 0
            creditsKnownForTableView.reloadData()
        } else {
            headerSeeFullBioButton.setTitle("See Full Bio", for: .normal)
            headerBioLabel.numberOfLines = 4
            headerView.frame.size.height = Constants.heightForHeader
            creditsKnownForTableView.reloadData()
        }
    }

    
    var id: Int?
    var creditsKnownForList = [CreditsKnownForUIModel]()
    var creditsDetailsList = [CreditsDetailsUIModel]()
    var contentHeight: [CGFloat] = []
    var creditsDetailsUIModel: CreditsDetailsUIModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        headerBioLabel?.lineBreakMode = .byWordWrapping
        headerBioLabel?.numberOfLines = 4
        getCreditsPage()
        getKnownForList()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrowBack"), style: .plain, target: self, action: #selector(popViewController))
    }
    
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func getCreditsPage() {
        TmDBService.instance.getCreditsDetails(id: id ?? 0, completion: { credit  in
            let creditsDetailsUIModel = CreditsDetailsUIModel(birthday: credit.birthday ?? "", known_for_department: credit.known_for_department, deathday: credit.deathday ?? "", id: credit.id, name: credit.name, gender: credit.gender, biography: credit.biography, popularity: credit.popularity, place_of_birth: credit.place_of_birth ?? "", profile_path: credit.profile_path ?? "")
            self.creditsDetailsList.append(creditsDetailsUIModel)
            let labelHeight = creditsDetailsUIModel.biography.height(withConstrainedWidth: UIScreen.main.bounds.width,font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular))
            self.contentHeight.append(labelHeight)

            let creditsPosterUrl = Constants.creditsArtworkUrl + creditsDetailsUIModel.profile_path
            let birthDate = DateFixer.dateConfig(enteredDate: creditsDetailsUIModel.birthday)
            DispatchQueue.main.async { [weak self] in
                self?.headerNameLabel.text = creditsDetailsUIModel.name
                self?.headerBioLabel.text = creditsDetailsUIModel.biography
                self?.headerBirthLabel.text = birthDate! + " in " + creditsDetailsUIModel.place_of_birth
                self?.headerImageView.kf.setImage(with: URL(string: creditsPosterUrl))
            }
        })
    }
    
    func getKnownForList() {
        TmDBService.instance.getCreditsKnownFor(id: id ?? 0 , completion: { knownForCredits  in
            for knownFor in knownForCredits {
                let creditsKnownForUIModel = CreditsKnownForUIModel(character: knownFor.character, title: knownFor.title ?? "", gender: knownFor.gender, release_date: knownFor.release_date ?? "", poster_path: knownFor.poster_path ?? "", media_type: knownFor.media_type ?? "", id: knownFor.id)
                self.creditsKnownForList.append(creditsKnownForUIModel)
                
                DispatchQueue.main.async {
                    self.creditsKnownForTableView.reloadData()
                }
            }
        })
    }
}
