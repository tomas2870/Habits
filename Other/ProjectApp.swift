//
//  ProjectApp.swift
//  Project
//
//  Created by Tomas Gonzalez on 12/2/23.
//

import SwiftUI
import SwiftData
import FirebaseCore

// Copied from firebase to allow me to use firebase within the app
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

// Run the app and focus on mainview
@main
struct ProjectApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
