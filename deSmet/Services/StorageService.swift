//
//  StorageService.swift
//  deSmet
//
//  Created by Apple on 26/3/23.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

class StorageService {
    
    static var storage = Storage.storage()
    
    static var storageRoot = storage.reference(forURL: "gs://desmet-31fde.appspot.com")
    
    static var storageProfile = storageRoot.child("profile")
    
    
    static func storageProfileID(userID: String) -> StorageReference {
        return storageProfile.child(userID)
    }
    
    static func saveProfileImage(userID: String, username: String, email: String, imageData: Data, metaData: StorageMetadata, storageProfileImageRef: StorageReference, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        storageProfileImageRef.putData(imageData, metadata: metaData) {
            (StorageMetadata, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            storageProfileImageRef.downloadURL {
                (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                        changeRequest.photoURL = url
                        changeRequest.displayName = username
                        changeRequest.commitChanges{
                            (error) in
                            if error != nil {
                                onError(error!.localizedDescription)
                                return
                            }
                        }
                    }
                    
                    let firestoreUserId = AuthService.getUserID(userID: userID)
                    let user = User.init(uid: userID, profileImageUrl: metaImageUrl, username: username, searchName: username.splitString(), bio: "")
                    
                    guard let dict = try?user.asDictinary() else {return}
                    
                    firestoreUserId.setData(dict){
                        (error) in
                        if error != nil {
                            onError(error!.localizedDescription)
                        }
                    }
                    
                    onSuccess(user)
                    
                }
            }
        }
        
    }
    
}
