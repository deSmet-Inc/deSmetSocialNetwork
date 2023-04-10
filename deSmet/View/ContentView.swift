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
    Group {
      if (session.session != nil ) {
        MainTabView()

      } else {
        LoginView()
      }
    }
    .onAppear(perform: listen)
  }
  
  struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
    }
  }
}
