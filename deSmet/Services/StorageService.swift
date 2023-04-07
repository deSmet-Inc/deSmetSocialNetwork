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
  
  static var storageRoot = storage.reference()
  
  static var storageProfile = storageRoot.child("profile")
  
  static var storagePost = storageRoot.child("posts")
  
  static func storagePostID(postID: String) -> StorageReference {
    return storagePost.child(postID)
  }
  
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
  
  static func savePostPhoto(userID: String, caption: String, postID: String, imageData: Data, metadata: StorageMetadata, storagePostRef: StorageReference, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
    
    storagePostRef.putData(imageData, metadata: metadata) {
      (StorageMetadata, error) in
      
      if error != nil {
        onError(error!.localizedDescription)
        return
      }
      
      storagePostRef.putData(imageData, metadata: metadata) {
        (StorageMetadata, error) in
        
        if error != nil {
          onError(error!.localizedDescription)
          return
        }
        
        storagePostRef.downloadURL {
          (url, error) in
          if let metaImageUrl = url?.absoluteString {
            let firestorePostRef = PostService.PostsUserID(userID: userID).collection("posts").document(postID)
            let post = PostModel.init(caption: caption, likes: [:], geolocation: "", ownerID: userID, postID: postID, username: Auth.auth().currentUser!.displayName!, profile: Auth.auth().currentUser!.photoURL!.absoluteString, mediaUrl: metaImageUrl, date: Date().timeIntervalSince1970, likeCount: 0)
            
            guard let dict = try? post.asDictinary() else { return }
            
            firestorePostRef.setData(dict) {
              (error) in
              if error != nil {
                onError(error!.localizedDescription)
                return
              }
              
              PostService.timelineUserID(userID: userID).collection("timeline").document(postID).setData(dict)
              
              PostService.AllPosts.document(postID).setData(dict)
              onSuccess()
            }
          }
        }
      }
    }
  }
}
