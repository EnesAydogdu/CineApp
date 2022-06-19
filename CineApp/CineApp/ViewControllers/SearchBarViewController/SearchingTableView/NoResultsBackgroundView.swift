//
//  NoResultsBackgroundView.swift
//  CineApp
//
//  Created by Enes Aydogdu on 9.06.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import UIKit

class NoResultsBackgroundView: UIView {
    
    @IBOutlet var noResultsBackgroundView: NoResultsBackgroundView!
    @IBOutlet weak var noResultsImageView: UIImageView!
    @IBOutlet weak var noResultsLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("NoResultsBackgroundView", owner: self, options: nil)
        addSubview(noResultsBackgroundView)
        noResultsBackgroundView.frame = self.bounds
        noResultsBackgroundView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
