//
//  Tab.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 25.09.22.
//

import SwiftUI

struct TabItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: String
    var tab: Tab
    var color: Color
}

var tabItems = [
    TabItem(text: "Home", icon: "house", tab: .home, color: .teal),
    TabItem(text: "Explore", icon: "magnifyingglass", tab: .explore, color: .red),
    TabItem(text: "Add", icon: "camera", tab: .AR, color: .purple),
    TabItem(text: "Messenger", icon: "message", tab: .Messenger, color: .green),
    TabItem(text: "Profile", icon: "person", tab: .Profile, color: .blue)
]

enum Tab: String {
    case home
    case explore
    case AR
    case Messenger
    case Profile
}

struct TabPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
