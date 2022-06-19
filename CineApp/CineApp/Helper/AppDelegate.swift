//
//  AppDelegate.swift
//  CineApp
//
//  Created by Enes Aydogdu on 31.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()

        return true
    }
}
