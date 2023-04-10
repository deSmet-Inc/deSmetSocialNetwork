//
//  PostService.swift
//  deSmet
//
//  Created by Иван Ровков on 08.04.2023.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage

class PostService {
  
  static var Posts = AuthService.storeRoot.collection("posts")
  static var AllPosts = AuthService.storeRoot.collection("allPosts")
  static var Timeline = AuthService.storeRoot.collection("timeline")

  
  static func PostsUserID(userID: String) -> DocumentReference {
    return Posts.document(userID)
  }
  
  static func timelineUserID(userID: String) -> DocumentReference {
    return Timeline.document(userID)
  }
  
  static func uploadPost(caption: String, imageData: Data, onSucces: @escaping() -> Void, onError: @escaping (_ errorMessage: String) -> Void ) {
    guard let userID = Auth.auth().currentUser?.uid else {
      return
    }
    
    let postID = PostService.PostsUserID(userID: userID).collection("posts").document().documentID
    let storagePostRef = StorageService.storagePostID(postID: postID)
    let metadata = StorageMetadata()
    metadata.contentType = "image/jpg"
    
    StorageService.savePostPhoto(userID: userID, caption: caption, postID: postID, imageData: imageData, metadata: metadata, storagePostRef: storagePostRef, onSuccess: onSucces, onError: onError)
  }
  
  static func loadUserPosts(userID: String, onSucces: @escaping(_ posts: [PostModel]) -> Void) {
    PostService.PostsUserID(userID: userID).collection("posts").getDocuments { (snapshot, error) in
      guard let snap = snapshot else {
        print("Error")
        return
      }
      
      var posts = [PostModel]()
      
      for doc in snap.documents {
        let dict = doc.data()
        
        guard let decoder = try? PostModel.init(fromDictionary: dict)
                
        else {
          return
        }
        
        posts.append(decoder)
      }
      onSucces(posts)
    }
    
  }
}
