//
//  AppDelegate.swift
//  ChatApp
//
//  Created by Hisham Ashraf Salah on 10/7/20.
//

import UIKit
import Firebase
import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate{
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self

        return true
    }
          
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {

        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        return GIDSignIn.sharedInstance().handle(url)
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else {
            if let error = error {
            print("failed to sign in with google: \(error)")
            }
            return
        }
        guard let user = user else {
            print("no google user found")
            return
        }
        print("signed in with google: \(user)")
        guard let email = user.profile.email, let firstName = user.profile.givenName, let lastName = user.profile.familyName else {
            print ("missing google account info")
            return
        }
        
        DatabaseManager.shared.userExists(with: email, completion: {exists in
            if !exists {
                let chatUser = chatAppUser(firstName: firstName,
                                           lastName: lastName,
                                           emailAdress: email)
                DatabaseManager.shared.insertUser(with: chatUser, completion: {success in
                    if success {
                        
                    }
                    
                })
            }
        })
        
        guard let authentication = user.authentication else {
            print("missing google authentication object")
            return
        }
          let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                            accessToken: authentication.accessToken)
        Firebase.Auth.auth().signIn(with: credential, completion: {authResult, error in
            guard authResult != nil, error == nil else {
                print("error signin with google account credehtials")
                return
            }
            print("logged in successfully with google credentials")
            NotificationCenter.default.post(name: .didLoginNotification, object: nil)
        })
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("user disconnected from google!")
    }
}


