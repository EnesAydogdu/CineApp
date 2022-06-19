//
//  MovieGenreModel.swift
//  CineApp
//
//  Created by Enes Aydogdu on 12.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation
import UIKit

class MovieGenreModel: Codable {
    let genres: [MovieGenreService]

    init(genres: [MovieGenreService]) {
        self.genres = genres
    }
}
class MovieGenreService : Codable {
    
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
