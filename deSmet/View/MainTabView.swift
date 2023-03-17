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
                    HomeScreenView()
                case .explore:
                    ExploreView()
                case .AR:
                    ExploreView()
                case .Messenger:
                    MessangerView()
                case .Profile:
                    ZStack(alignment: .topTrailing) {
                        ProfileView()
                    }
//                    SideBarView()
//
//                    .toolbar {
//                        ToolbarItem(placement: .navigationBarTrailing) {
//                            Button {
//                                isSideBarShow.toggle()
//                            } label: {
//
//                            }
//
//                        }
//                    }
//                    ZStack {
//                        if isSideBarShow {
//                            SideBarView(isSideBarShow: $isSideBarShow)
//
//                        }
//
//                        ZStack {
//
//                            Color(.white)
//                                .ignoresSafeArea()
//                            VStack(alignment: .trailing) {
//                                Button {
//                                    withAnimation(.spring()){
//                                        isSideBarShow.toggle()
//                                    }
//                                } label: {
//                                    Image(systemName: "ellipsis")
//                                        .foregroundColor(isSideBarShow ? .white : .black)
//                                }
//                                .padding(.trailing, 30)
//                                .padding(8)
//
//                                ProfileView()
//                            }
//                        }
//                        .cornerRadius(isSideBarShow ? 20 : 10)
//                        .offset(x: isSideBarShow ? -300 : 0, y: isSideBarShow ? 34 : 0)
//                        .scaleEffect( isSideBarShow ? 0.8 : 1)
//                    }
                }
            }
            TabBar()
//                .offset(x: isSideBarShow ? 0 : 0, y: isSideBarShow ? 90 : 0)
//                .ignoresSafeArea()

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


struct LogOut: View {
//    @EnvironmentObject var viewModel: AuthModel
    var body: some View{
        Button {
//            viewModel.signOut()
        } label: {
            
        }
   
    }
}


