//
//  StatusBarUtil.swift
//  CineApp
//
//  Created by Enes Aydogdu on 16.06.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation
import UIKit

class StatusBarUtil {
    
    static let instance = StatusBarUtil()
    
    func StatusBarBackgroundColor(endpoint: UIView, color: UIColor) -> Void {
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = color
        statusBarView.backgroundColor = statusBarColor
        endpoint.addSubview(statusBarView)
    }
}
