//
//  RegisterPageViewController.swift
//  CineApp
//
//  Created by Enes Aydogdu on 10.06.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import UIKit
import WebKit

class RegisterPageViewController: UIViewController, WKNavigationDelegate {

    enum constants {
        static let registerWebUrl = URL(string: "https://www.themoviedb.org/account/signup")
    }
    
    var registerWebPage: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerWebPage.load(URLRequest(url: constants.registerWebUrl!))
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: registerWebPage, action: #selector(registerWebPage.reload))
        toolbarItems = [refreshButton]
        navigationController?.isToolbarHidden = false
    }
    
    override func loadView() {
        registerWebPage = WKWebView()
        registerWebPage.navigationDelegate = self
        view = registerWebPage
    }

}
