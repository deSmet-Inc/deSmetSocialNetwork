//
//  deSmetApp.swift
//  deSmet
//
//  Created by Jacob Shushanyan on 19.09.22.
//
import SwiftUI
import Firebase
import FirebaseAuth


@main
struct deSmetApp: App {
  
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
          ContentView().environmentObject(SessionStore())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil ) -> Bool {
    print("Firebase...")
    FirebaseApp.configure()
    return true
  }
}
