//
//  TestView.swift
//  deSmet
//
//  Created by Иван Ровков on 01.04.2023.
//

import SwiftUI

struct TestView: View {
  
  @EnvironmentObject var session: SessionStore
  
    var body: some View {
      
      VStack {
        Text("Hello, World!")
        Button(action: session.logout) {
          Text("Log out").font(.title)
        }
      }
      
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
