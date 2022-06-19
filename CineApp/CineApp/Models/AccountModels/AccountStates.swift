//
//  AccountStates.swift
//  CineApp
//
//  Created by Enes Aydogdu on 20.06.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation

class AccountStatesModel: Codable {
    
    let id: Int?
    let favorite: Bool?
    
    init(id: Int?, favorite: Bool?) {
        self.id = id
        self.favorite = favorite
    }
}
