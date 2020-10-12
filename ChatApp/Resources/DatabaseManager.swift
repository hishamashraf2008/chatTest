//
//  DatabaseManager.swift
//  ChatApp
//
//  Created by Hisham Ashraf Salah on 10/12/20.
//

import Foundation

import FirebaseDatabase

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}
extension DatabaseManager{
    func userExists(with email: String, completion: @escaping ((Bool) -> Void)){
        database.child(email).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    func insertUser(with user: chatAppUser){
        database.child(user.emailAdress).setValue([
            "first_Name": user.firstName,
            "last_Name": user.lastName
        ])
    }
}
struct chatAppUser{
    let firstName: String
    let lastName: String
    let emailAdress: String
    // let profilePictureURL: URL
    // password is not included to increase security
}

