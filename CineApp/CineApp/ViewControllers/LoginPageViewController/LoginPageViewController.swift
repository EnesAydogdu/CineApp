//
//  LoginPageViewController.swift
//  CineApp
//
//  Created by Enes Aydogdu on 10.06.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class LoginPageViewController: UIViewController {
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    var iconClick: Bool = true
    var savedToken: String?
    
    enum constants {
        static let forgotPasswordViewControllerId = "ForgotPasswordViewController"
    }
    
    @IBAction func skipButtonAction(_ sender: Any) {
        let tabbar: TabBarViewController? = (storyboard!.instantiateViewController(withIdentifier: "tabbar") as? TabBarViewController)
        self.navigationController?.pushViewController(tabbar!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineView.backgroundColor = UIColor.lightGray
        bottomLineView.backgroundColor = UIColor.lightGray
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        autologin()
    }
    
    func getApiResponse() {
        let username = usernameLabel.text
        let password = passwordLabel.text
        TmDBService.instance.getToken(completion: {requestToken in
            TmDBService.instance.token = requestToken.request_token
            if TmDBService.instance.token != nil {
                self.getAccess(username: username, password: password)
                
            }
        })
    }
    
    func getAccess(username: String?, password: String?) {
     
        TmDBService.instance.createSessionWithLogin(requestModel: LoginRequestModel(username: username, password: password, request_token: TmDBService.instance.token), completion: { requestToken, response  in
            if let isSuccess = response?.success, isSuccess {
                self.savedToken = response?.request_token
                DispatchQueue.main.async {
                    if let savedToken = self.savedToken {
                        KeychainWrapper.standard.set(savedToken, forKey: "SavedToken")
                    }
                }
            } else {
                self.showAlert()
            }
            if response?.success == true {
                self.getSessionId()
            }
        })
    }
    
    func getSessionId() {
        TmDBService.instance.createSessionID(requestModel: KeychainWrapper.standard.string(forKey: "SavedToken"), completion: { savedToken, sessionId in
            if let isSuccess = sessionId.success, isSuccess {
                DispatchQueue.main.async {
                    if let sessionId = sessionId.session_id {
                        KeychainWrapper.standard.set(sessionId, forKey: "SessionId")
                    }
                }
            }
            if sessionId.session_id != nil {
                self.getAccountDetails()
            }
        })
    }
    
    func getAccountDetails() {
        TmDBService.instance.getAccountDetails(requestModel: KeychainWrapper.standard.string(forKey: "SessionId"), completion: { accountDetails in
            DispatchQueue.main.async {
                if let accountId = accountDetails.id {
                    let accountIdString = String(accountId)
                    KeychainWrapper.standard.set(accountIdString, forKey: "AccountId")
                    if accountIdString != nil {
                        UserDefaults.standard.set(true, forKey: "IsLoggedIn")
                    }
                }
                self.navigateToUserProfileViewController()

            }
        })
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        getApiResponse()

        if let username = usernameLabel.text {
            KeychainWrapper.standard.set(username, forKey: "Username")
        }
        if let password = passwordLabel.text {
            KeychainWrapper.standard.set(password, forKey: "Password")
        }
    }
    
    func navigateToUserProfileViewController() {
        let tabbar: UITabBarController? = (storyboard!.instantiateViewController(withIdentifier: "tabbar") as? TabBarViewController)
        tabbar?.selectedIndex = 3
        self.navigationController?.pushViewController(tabbar!, animated: true)
    }
    
    func autologin() {
        if UserDefaults.standard.bool(forKey: "IsLoggedIn") == true{
            let tabbar: UITabBarController? = (storyboard!.instantiateViewController(withIdentifier: "tabbar") as? TabBarViewController)
            tabbar?.selectedIndex = 3
            self.navigationController?.pushViewController(tabbar!, animated: true)
        }
    }

    func showAlert() {
        DispatchQueue.main.sync {
            let alert = UIAlertController(title: "Alert", message: "Username or Password is not correct!", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func forgotPasswordButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let forgotPasswordViewController = storyboard.instantiateViewController(identifier: constants.forgotPasswordViewControllerId )  as? ForgotPasswordViewController else { return }
        navigationController?.pushViewController(forgotPasswordViewController, animated: true)
    }
    
    @IBAction func hidePasswordButtonAction(_ sender: Any) {
        if(iconClick == true) {
            passwordLabel.isSecureTextEntry = false
        } else {
            passwordLabel.isSecureTextEntry = true
        }
        iconClick = !iconClick
    }
}
