//
//  UserModel.swift
//  deSmet
//
//  Created by Apple on 26/3/23.
//

import Foundation

struct User: Encodable, Decodable{
    var uid: String
    var profileImageUrl: String
    var username: String
    var searchName: [String]
    var bio: String
}
