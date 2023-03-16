//
//  ProfileView.swift
//  deSmet
//
//  Created by Apple on 3/16/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        GeometryReader{
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            ProfileComp(safeArea: safeArea, size: size)
                .ignoresSafeArea(.container, edges: .top)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
