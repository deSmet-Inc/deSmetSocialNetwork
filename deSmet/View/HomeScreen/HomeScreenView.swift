//
//  HomeScreenView.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 25.09.22.
//

import SwiftUI
struct HomeScreenView: View {
    @EnvironmentObject var viewModel: AuthModel
        //var InfintySpace: VideoMetadata
    @AppStorage("selectedTab") var selectedTab: Tab = .home
        
    var body: some View {
        ZStack {
            VStack {
                Text("hello Home screen")
                Button {
                    AuthModel().signOut()
                } label: {
                    Text("Log out")
                }

               
            }
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
            HomeScreenView()
        
    }
}


