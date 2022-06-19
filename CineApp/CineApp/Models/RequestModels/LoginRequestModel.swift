//
//  LoginRequestModel.swift
//  CineApp
//
//  Created by Enes Aydogdu on 19.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation

class LoginRequestModel: Codable {
    
    var username: String?
    var password: String?
    var request_token: String?
    
    init(username: String?,
         password: String?,
         request_token: String?) {
        self.username = username
        self.password = password
        self.request_token = request_token
    }
}
