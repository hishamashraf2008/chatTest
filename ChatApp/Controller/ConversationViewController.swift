//
//  ViewController.swift
//  ChatApp
//
//  Created by Hisham Ashraf Salah on 10/7/20.
//

import UIKit

//  Home page

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        
        if !isLoggedIn{
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }

}

