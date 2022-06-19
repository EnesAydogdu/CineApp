//
//  MoviesTableCell.swift
//  CineApp
//
//  Created by Enes Aydogdu on 4.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import UIKit

class MoveeTableCell: UITableViewCell {

    @IBOutlet weak var viewOfCell: UIView!
    @IBOutlet weak var tableMovieImageView: UIImageView!
    @IBOutlet weak var tableMovieNameLabel: UILabel!
    @IBOutlet weak var tableGenreLabel: UILabel!
    @IBOutlet weak var tableMovieTimeLabel: UILabel!
    @IBOutlet weak var tableMovieDateLabel: UILabel!
    @IBOutlet weak var tableMovieRatingLabel: UILabel!
    @IBOutlet weak var tableMovieRatingView: UIView!
}
