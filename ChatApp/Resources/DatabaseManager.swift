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
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
          // replacing some signs in the email with - because some signs cant be stored in a child
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    func insertUser(with user: chatAppUser){
        database.child(user.safeEmail).setValue([
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
    
    var safeEmail: String {
        var safeEmail = emailAdress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-") // replacing some signs in the email with - because some signs cant be stored in a child
        return safeEmail
    }
}

