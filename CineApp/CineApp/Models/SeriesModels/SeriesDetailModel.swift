//
//  SeriesDetailModel.swift
//  CineApp
//
//  Created by Enes Aydogdu on 13.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation

class SeriesDetailModel: Codable {
    let id: Int
    let number_of_episodes: Int
    let number_of_seasons: Int
    let episode_run_time: [Int]
    let backdrop_path: String
    let first_air_date: String
    let last_air_date: String
    let overview: String?
    let vote_average: Double?
    let name: String?
    
    init(id: Int,number_of_episodes: Int,number_of_seasons:Int,episode_run_time:[Int], backdrop_path: String, first_air_date: String, last_air_date: String, overview: String?, vote_average: Double?, name: String?) {
        self.id = id
        self.number_of_seasons = number_of_seasons
        self.number_of_episodes = number_of_episodes
        self.episode_run_time = episode_run_time
        self.backdrop_path = backdrop_path
        self.first_air_date = first_air_date
        self.last_air_date = last_air_date
        self.overview = overview
        self.vote_average = vote_average
        self.name = name
    }
}
