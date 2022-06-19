//
//  SessionIdServiceModel.swift
//  CineApp
//
//  Created by Enes Aydogdu on 11.06.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation

class SessionIdResponseModel: Codable {
    
    let success: Bool?
    let session_id: String?
    
    init(success: Bool?, session_id: String?) {
        self.success = success
        self.session_id = session_id
    }
}
