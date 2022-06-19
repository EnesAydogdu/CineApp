//
//  CreditsDetailsModel.swift
//  CineApp
//
//  Created by Enes Aydogdu on 27.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation
import UIKit


class CreditsDetailsServiceModel: Codable {
    
    let birthday: String?
    let known_for_department: String
    let deathday: String?
    let id: Int
    let name: String
    let gender: Int
    let biography: String
    let popularity: Double
    let place_of_birth: String?
    let profile_path: String?
    
    init(birthday: String, known_for_department: String, deathday: String, id: Int, name: String, gender: Int, biography: String, popularity: Double, place_of_birth: String, profile_path: String) {
        self.birthday = birthday
        self.known_for_department = known_for_department
        self.deathday = deathday
        self.id = id
        self.name = name
        self.gender = gender
        self.biography = biography
        self.popularity = popularity
        self.place_of_birth = place_of_birth
        self.profile_path = profile_path
    }
}

