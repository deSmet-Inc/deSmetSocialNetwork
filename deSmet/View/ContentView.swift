//
//  ContentView.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 30.10.22.
//

import SwiftUI

struct ContentView: View {

  @EnvironmentObject var session: SessionStore
  
  func listen() {
    session.listen()
  }
  
  var body: some View {
        ZStack(alignment: .topLeading) {
          if session.session != nil {
            MainTabView()
                
            
            ExploreView()
                .frame(width: 300)
//                .offset(x: showSideBar ? 0 : 300, y: 0)
//                .background(showSideBar ? Color.white : Color.clear)
          } else {
            LoginView()
          }
        }
    
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
//                    showSideBar.toggle()
                } label: {
                    Circle()
                        .frame(width: 32, height: 32)
                }

            }
        }
        .onAppear(perform: listen)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
