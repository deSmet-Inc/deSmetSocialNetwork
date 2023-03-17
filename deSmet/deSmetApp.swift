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
    
    @StateObject var launchScreenManager = LaunchScreenManager()
//    @StateObject var viewModel = AuthModel()
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                    LoginView()
//                        .environmentObject(viewModel)
//
//                if  launchScreenManager.state != .completed {
//                    LaunchScreenView()
//                }
            }
//            .environmentObject(launchScreenManager)
        }
    }
    
//    class Appdelegate: NSObject, UIApplicationDelegate {
//
//        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOption:
//                         [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//
//            FirebaseApp.configure()
//            print("OK")
//
//            return true
//        }
//    }
//
}
