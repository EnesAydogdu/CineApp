//
//  KnownForTableViewCell.swift
//  CineApp
//
//  Created by Enes Aydogdu on 27.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import UIKit

class KnownForTableViewCell: UITableViewCell {

    @IBOutlet weak var creditsKnownForView: UIView!
    @IBOutlet weak var creditsKnownForMovieNameLabel: UILabel!
    @IBOutlet weak var creditsKnownForImageView: UIImageView!
    @IBOutlet weak var creditsKnownForCharacterLabel: UILabel!
    @IBOutlet weak var creditsKnownForDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
