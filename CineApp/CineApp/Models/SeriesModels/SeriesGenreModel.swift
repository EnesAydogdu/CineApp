//
//  SeriesGenreService.swift
//  CineApp
//
//  Created by Enes Aydogdu on 15.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation

class SeriesGenreModel: Codable {
    let genres: [SeriesGenreService]

    init(genres: [SeriesGenreService]) {
        self.genres = genres
    }
}
class SeriesGenreService : Codable {
    
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
