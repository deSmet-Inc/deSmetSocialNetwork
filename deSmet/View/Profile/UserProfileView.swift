//
//  UserProfileView.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 24.10.22.
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
        VStack {
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
                // Buttons follow, message
                HStack{
                    Button {
                        
                    } label: {
                        Text("Follow")
                            .foregroundColor(.white)
                            .frame(width: 160, height: 42)
                            .background(Color("LaunchScreenBackground"))
                            .cornerRadius(12)
                    }
                    Button {
                        
                    } label: {
                        Text("Message")
                            .foregroundColor(.white)
                            .frame(width: 160, height: 42)
                            .background(Color("LaunchScreenBackground"))
                            .cornerRadius(12)
                    }
                }
            }
            .padding(.top, 55)
            
            
            
            Divider()
            
            Spacer()
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}


extension UserProfileView {
    var headerView: some View {
        ZStack(alignment: .center){
            Color("LaunchScreenBackground")
                .ignoresSafeArea()

            VStack {
                // Buttons
                HStack {
                    Button {

                    } label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 20, height: 16)
                            .foregroundColor(.white)

                }

                    Spacer()

                    Button {

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
