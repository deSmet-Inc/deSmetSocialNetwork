//
//  RoundedShape.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 03.10.22.
//

import SwiftUI

struct RoundedShape: Shape {
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 80, height: 80))

        return Path(path.cgPath)
    }
    
}
