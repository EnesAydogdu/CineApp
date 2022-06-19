//
//  SearchingUIModel.swift
//  CineApp
//
//  Created by Enes Aydogdu on 4.06.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation

class SearchingUIModel {
    let posterPath: String?
    let id: Int?
    let backdropPath: String?
    let mediaType: String?
    let name: String?
    let title: String?
    let profilePath: String?
    var cast: String?
    
    init(posterPath: String?, id: Int?, backdropPath: String?, mediaType: String?, name: String?, title: String?, profile_path: String?, cast: String?) {
        self.posterPath = posterPath
        self.id = id
        self.backdropPath = backdropPath
        self.mediaType = mediaType
        self.name = name
        self.title = title
        self.profilePath = profile_path
        self.cast = cast
    }
}
