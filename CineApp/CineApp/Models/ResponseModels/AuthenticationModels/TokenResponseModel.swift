//
//  TokenResponseModel.swift
//  CineApp
//
//  Created by Enes Aydogdu on 11.06.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation

struct TokenResponseModel: Codable {
    
    let success: Bool
    let expires_at: String?
    let request_token: String?
    
    init(success: Bool,
         expires_at: String?,
         request_token: String?) {
        self.success = success
        self.expires_at = expires_at
        self.request_token = request_token
    }
}
