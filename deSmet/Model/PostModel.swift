//
//  PostModel.swift
//  deSmet
//
//  Created by Иван Ровков on 08.04.2023.
//

import Foundation

struct PostModel: Encodable, Decodable {
  var caption: String
  var likes: [String: Bool]
  var geolocation: String
  var ownerID: String
  var postID: String
  var username: String
  var profile: String
  var mediaUrl: String
  var date: Double
  var likeCount: Int
  
}
