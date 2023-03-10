//
//  ProfileView.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 28.09.22.
//

import SwiftUI

struct ProfileView: View {
//    @EnvironmentObject var viewModel: AuthModel
    @AppStorage("selectedTab") var selectedTab: Tab = .home
//    @Binding var selectedSideBar: String
    @State var showSideBar = false
//    @State  var isFollowed = false
    
    var body: some View {

        ZStack(alignment: .topTrailing){
            VStack{
                headerView

                VStack{
                    // username
                    HStack {
                        Text("Jacob")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .padding(4)
                    // Bio
                    HStack {
                        Text("About me")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                    
                    UserStatsView()
                        .padding(.top, 8)
                    // Buttons adding
                    HStack{
                        Button {
                            
                        } label: {
                            Text("Add")
                                .foregroundColor(.white)
                                .frame(width: 340, height: 42)
                                .background(Color("LaunchScreenBackground"))
                                .cornerRadius(12)
                        }
                    }
                }
                .padding(.top, 55)
                
                
                
                Divider()
                
                Spacer()
            }

            if showSideBar {
                ZStack{
                    Color(.black)
                        .opacity(showSideBar ? 0.25 : 0.0)
                }.onTapGesture {
                    withAnimation(.easeInOut){
                        showSideBar = false
                    }
                }
                .ignoresSafeArea()
            }
            
            
            SideBarView()
                .frame(width: 300)
                .offset(x: showSideBar ? -10 : 300, y: 0)
                .background(showSideBar ? Color.white : Color.clear)
        }
    }
}

    
    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
                ProfileView()
        }
    }


extension ProfileView {
    var headerView: some View {
        ZStack(alignment: .center){
            Color("LaunchScreenBackground")
                .ignoresSafeArea()

            VStack {
                // Buttons
                HStack {
                    Button {

                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .resizable()
                            .frame(width: 20, height: 16)
                            .foregroundColor(.white)

                }
                    
                    Spacer()
                    
                    Button {
                        withAnimation(.easeInOut) {
                            showSideBar.toggle()
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .scaleEffect(2)
                            .foregroundColor(.white)

                }
                    
            }
                    .padding(.horizontal)

                Circle()
                    .frame(width: 96, height: 96)
                    .offset(y: 42)
            }
        
        }
        .frame(height: 96)

    }
}



