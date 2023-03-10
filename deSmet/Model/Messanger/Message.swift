//
//  Message.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 29.09.22.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
}
