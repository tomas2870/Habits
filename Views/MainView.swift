//
//  ContentView.swift
//  Project
//
//  Created by Tomas Gonzalez on 12/2/23.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    
    var body: some View {
        // If user is signed in
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            // Displaye signed in view
            TabView {
                HabitsView(userId: viewModel.currentUserId)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .toolbarBackground(Color.white, for: .tabBar)
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.circle")
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white)
                                    .padding()
                            )
                    }
            }

        }
        // If they're not signed in
        else {
            // Take them to login screen
            LoginView()
        }
        
    }
    

}

#Preview {
    MainView()
}
