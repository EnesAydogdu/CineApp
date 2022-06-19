//
//  SeriesModel.swift
//  CineApp
//
//  Created by Enes Aydogdu on 13.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation

//class SeriesModel: Codable {
//    let results: [SeriesServiceModel]
//
//    init(results: [SeriesServiceModel]) {
//        self.results = results
//    }
//}
//
//class SeriesServiceModel: Codable {
//
//    let name: String
//    let id: Int
//    let vote_average: Double
//    let overview: String
//    let poster_path: String
//
//    init(name: String, id: Int, vote_average: Double, overview: String,poster_path: String) {
//        self.name = name
//        self.id = id
//        self.vote_average = vote_average
//        self.overview = overview
//        self.poster_path = poster_path
//    }
//}


struct SeriesModel: Codable {
    let page: Int?
    let results: [SeriesServiceModel]
}

// MARK: - Result
struct SeriesServiceModel: Codable {
    let posterPath: String?
    let popularity: Double?
    let id: Int?
    let backdropPath: String?
    let voteAverage: Double?
    let overview, firstAirDate: String?
    let originCountry: [String?]
    let genreIDS: [Int?]
    let originalLanguage: String?
    let voteCount: Int?
    let name, originalName: String?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case popularity, id
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case overview
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
    }
}
