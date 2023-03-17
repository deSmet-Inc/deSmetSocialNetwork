//
//  AuthService.swift
//  deSmet
//
//  Created by Apple on 26/3/23.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class AuthService {
    
    static var storeRoot = Firestore.firestore()
    
    static func getUserID(userID: String) -> DocumentReference {
        return storeRoot.collection("users").document(userID)
    }
    
    static func signUp(username: String, email: String, password: String, imageData: Data, onSuccess: @escaping (_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {
            (authData, error) in
        
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            guard let userID = authData?.user.uid else {return}
            
            let storageProfileUserId = StorageService.storageProfileID(userID: userID)
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            
            StorageService.saveProfileImage(userID: userID, username: username, email: email, imageData: imageData, metaData: metadata, storageProfileImageRef: storageProfileUserId, onSuccess: onSuccess, onError: onError)
        }
    }
    
}
