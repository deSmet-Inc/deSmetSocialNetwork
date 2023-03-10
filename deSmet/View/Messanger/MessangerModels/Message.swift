//
//  Message.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 16.10.22.
//

import Foundation

struct Message: Codable {
    var ConversessionID: String
    var text: String
    var received: Bool
    var timestamp: Date
}
