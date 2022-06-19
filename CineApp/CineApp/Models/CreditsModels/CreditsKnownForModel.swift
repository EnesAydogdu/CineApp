//
//  CreditsKnownForModel.swift
//  CineApp
//
//  Created by Enes Aydogdu on 27.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation
import UIKit

class CreditsKnownForModel: Codable {
    
    let cast: [CreditsKnownForServiceModel]
    
    init(cast: [CreditsKnownForServiceModel]) {
        self.cast = cast
    }
}

class CreditsKnownForServiceModel: Codable {
    
    let id: Int?
    let character: String?
    let title: String?
    let gender: Int?
    let release_date: String?
    let poster_path: String?
    let media_type: String?
    
    init(id: Int, character: String?, title: String?, gender: Int?, release_date: String?, poster_path: String?, media_type: String?) {
        self.id = id
        self.character = character
        self.title = title
        self.gender = gender
        self.release_date = release_date
        self.poster_path = poster_path
        self.media_type = media_type
    }
}
