//
//  AccountDetailsModel.swift
//  CineApp
//
//  Created by Enes Aydogdu on 19.06.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation

class AccountDetailsModel: Codable {
    
    let id: Int?
    let name: String?
    let username: String?
    
    init(id: Int?, name: String?, username: String?) {
        self.name = name
        self.username = username
        self.id = id
    }
}
