//
//  ProfileService.swift
//  deSmet
//
//  Created by Иван Ровков on 11.04.2023.
//

import Foundation

class ProfileService: ObservableObject {
  @Published var posts: [PostModel] = []
  
  func loadUserPosts(userID: String) {
    PostService.loadUserPosts(userID: userID) { posts in
      self.posts = posts
    }
  }
}
