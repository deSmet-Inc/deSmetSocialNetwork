//
//  SideBarButton.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 09.10.22.
//

import SwiftUI

struct SideBarButton: View {
    var image: String
    var title: String
    
    @Binding var selectedSideBar: String
    
    var animation: Namespace.ID
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()){selectedSideBar = title}
        }, label: {
            HStack(spacing: 15){
                
                Image(systemName: image)
                    .font(.title2)
                    .frame(width: 30)
                Text(title)
                    .fontWeight(.semibold)
            }
            .foregroundColor(selectedSideBar == title ? Color("LaunchScreenBackground") : .white)
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .background(
                Color.white
                    .opacity(selectedSideBar == title ? 1 : 0)
                    .clipShape(CustomCorners(corners: [.topLeft, .bottomLeft], radius: 16))
            )
        })
    }
}

