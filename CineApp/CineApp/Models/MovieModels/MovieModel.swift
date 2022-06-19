//
//  Movies.swift
//  CineApp
//
//  Created by Enes Aydogdu on 5.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import UIKit
import Foundation

class Movies: Codable {
    let results: [MovieServiceModel]
    
    init(results: [MovieServiceModel]) {
        self.results = results
    }
}
class MovieServiceModel: Codable {
    
    let poster_path: String?
    let id: Int?
    let title: String?
    let vote_average: Double?
    let overview: String?
    let release_date: String?
    let backdrop_path: String?

    init(poster_path : String? , id: Int?, title : String?, vote_average : Double?, overview : String?, release_date : String?, backdrop_path: String?) {
    self.poster_path = poster_path
    self.id = id
    self.title = title
    self.vote_average = vote_average
    self.overview = overview
    self.release_date = release_date
    self.backdrop_path = backdrop_path
    }
}
