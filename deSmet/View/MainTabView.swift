//
//  HeadView.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 28.09.22.
//

import SwiftUI

struct MainTabView: View {
    @State var selectedSideBar = "Home"
//    @AppStorage("Home") var selectedSideBar: Tab = .home

    @AppStorage("selectedTab") var selectedTab: Tab = .home
    
    @State var isSideBarShow = false
    
    var body: some View {
        ZStack{
            Group {
                switch selectedTab {
                case .home:
                    ExploreView()
                case .explore:
                    ExploreView()
                case .uploadPost:
                    UploadPostView()
                case .Messenger:
                    MessangerView()
                case .Profile:
                    ZStack(alignment: .topTrailing) {
                        ProfileView()
                    }
                }
            }
            TabBar()
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 44)
        }
    }
}

struct HeadView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}


