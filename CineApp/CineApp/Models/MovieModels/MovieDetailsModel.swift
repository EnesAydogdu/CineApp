//
//  MovieDetailsModel.swift
//  CineApp
//
//  Created by Enes Aydogdu on 7.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//
//
import Foundation

class MovieDetailsModel : Codable {
    let id: Int
    let runtime: Int
    let poster_path: String?
    let title: String
    let vote_average: Double
    let overview: String
    let release_date: String
    let backdrop_path: String?
    let genres: [MovieGenreService]
    
    init (id: Int, runtime: Int, poster_path: String?, title: String, vote_average: Double, overview: String, release_date: String, backdrop_path: String?, genres: [MovieGenreService]) {
        self.id = id
        self.runtime = runtime
        self.poster_path = poster_path
        self.title = title
        self.vote_average = vote_average
        self.overview = overview
        self.release_date = release_date
        self.backdrop_path = backdrop_path
        self.genres = genres
    }
}
