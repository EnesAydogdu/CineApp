//
//  SearchingModel.swift
//  CineApp
//
//  Created by Enes Aydogdu on 4.06.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation

class SearchingModel: Codable {
    
    let results: [SearchingServiceModel]
    
    init(results: [SearchingServiceModel]) {
        self.results = results
    }
}

class SearchingServiceModel: Codable {
    
    let poster_path: String?
    let id: Int?
    let backdrop_path: String?
    let media_type: String?
    let name: String?
    let title: String?
    let profile_path: String?
    
    init(poster_path: String?, id: Int?, backdrop_path: String?, media_type: String?, name: String?, title: String?, profile_path: String?) {
        self.poster_path = poster_path
        self.id = id
        self.backdrop_path = backdrop_path
        self.media_type = media_type
        self.name = name
        self.title = title
        self.profile_path = profile_path
    }
}
