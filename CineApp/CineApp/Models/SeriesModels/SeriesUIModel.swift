//
//  SeriesUIModel.swift
//  CineApp
//
//  Created by Enes Aydogdu on 13.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation

class SeriesUIModel: Codable {
    var name: String?
    var id: Int?
    var vote_average: String?
    var overview: String?
    var poster_path: String?
    var number_of_episodes: String?
    var number_of_seasons: String?
    var genres: String?
    var episode_run_time: String?
    var backdrop_path: String?
    var dates: String?
    var favorite: Bool?
    
    init(name: String?, id: Int?, vote_average: String?, poster_path: String?, overview: String?, number_of_episodes: String?, number_of_seasons: String?, genres: String?, episode_run_time: String?, backdrop_path: String?, dates: String?, favorite: Bool?) {
        self.name = name
        self.id = id
        self.vote_average = vote_average
        self.overview = overview
        self.poster_path = poster_path
        self.number_of_episodes = number_of_episodes
        self.number_of_seasons = number_of_seasons
        self.genres = genres
        self.episode_run_time = episode_run_time
        self.backdrop_path = backdrop_path
        self.dates = dates
        self.favorite = favorite
    }
    
    init(id: Int?) {
        self.id = id
    }
}
