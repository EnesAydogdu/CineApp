//
//  CreditsDetailsUIModel.swift
//  CineApp
//
//  Created by Enes Aydogdu on 27.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation

class CreditsDetailsUIModel: Codable {
    
    var birthday: String = ""
    var known_for_department: String = ""
    var deathday: String = ""
    var id: Int = 0
    var name: String = ""
    var gender: Int = 0
    var biography: String = ""
    var popularity: Double = 0
    var place_of_birth: String = ""
    var profile_path: String = ""
    
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
    
    init(id: Int) {
        self.id = id
    }
}
