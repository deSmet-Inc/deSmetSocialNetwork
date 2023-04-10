//
//  PostCardService.swift
//  deSmet
//
//  Created by Иван Ровков on 11.04.2023.
//

import Foundation
import Firebase
import SwiftUI

class PostCardService: ObservableObject {
  @Published var post: PostModel!
  @Published var isLiked = false
  
  func hasLikedPost() {
    isLiked = (post.likes["\(Auth.auth().currentUser!.uid)"] == true ) ? true : false
  }
  
  func like() {
    post.likeCount += 1
    isLiked = true
    
    PostService.PostsUserID(userID: post.ownerID).collection("posts").document(post.postID).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true] )
    
    PostService.AllPosts.document(post.postID).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true] )
    
    PostService.timelineUserID(userID: post.ownerID).collection("timeline").document(post.postID).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
  }
  
  func unlike() {
    post.likeCount -= 1
    isLiked = false
    
    PostService.PostsUserID(userID: post.ownerID).collection("posts").document(post.postID).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": false] )
    
    PostService.AllPosts.document(post.postID).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": false] )
    
    PostService.timelineUserID(userID: post.ownerID).collection("timeline").document(post.postID).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": false])
  }
  
}
