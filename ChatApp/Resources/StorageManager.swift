//
//  StorageManager.swift
//  ChatApp
//
//  Created by Hisham Ashraf Salah on 10/19/20.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    // upload picture to firebase storage
    
    typealias uploadPictureComplete = (Result<String,Error>)->Void
    
    func uploadProfilePicture(with data: Data, fileName: String, completion: @escaping uploadPictureComplete){
        storage.child("image\(fileName)").putData(data, metadata: nil, completion: {metadeta, error in
            guard error == nil else {
                print("failed to upload picture to firebase")
                completion(.failure(storageErrors.failedToUpload))
                return
            }
            // if the picture gets uploaded, we need to download the url back to use the photo.
            self.storage.child("image\(fileName)").downloadURL(completion: {url, error in
                guard let url = url else {
                    print("failed to download picture url back")
                    completion(.failure(storageErrors.failedToDownload))
                    return
                }
                let urlString = url.absoluteString
                print("download url string: \(urlString)")
            })
        })
    }
    enum storageErrors: Error{
        case failedToUpload
        case failedToDownload
    }
}
