//
//  ViewController.swift
//  ChatApp
//
//  Created by Hisham Ashraf Salah on 10/7/20.
//

import UIKit
import FirebaseAuth

//  Home page

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userValidation()
    }
    private func userValidation(){
        
        if FirebaseAuth.Auth.auth().currentUser == nil{
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }

}

