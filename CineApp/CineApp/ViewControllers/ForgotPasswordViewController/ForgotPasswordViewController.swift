//
//  ForgotPasswordViewController.swift
//  CineApp
//
//  Created by Enes Aydogdu on 16.06.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import UIKit
import WebKit

class ForgotPasswordViewController: UIViewController, WKNavigationDelegate {

    enum constants {
        static let forgotPasswordWebUrl = URL(string: "https://www.themoviedb.org/account/reset-password")
    }
        
    var forgotPasswordWebPage: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forgotPasswordWebPage.load(URLRequest(url: constants.forgotPasswordWebUrl!))
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: forgotPasswordWebPage, action: #selector(forgotPasswordWebPage.reload))
        toolbarItems = [refreshButton]
        navigationController?.isToolbarHidden = false
    }
    
    override func loadView() {
        forgotPasswordWebPage = WKWebView()
        forgotPasswordWebPage.navigationDelegate = self
        view = forgotPasswordWebPage
    }
}
