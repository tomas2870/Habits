//
//  GoalsView.swift
//  Project
//
//  Created by Tomas Gonzalez on 5/19/24.
//

import SwiftUI

struct GoalsView: View {
    @StateObject var viewModel = GoalsViewViewModel()
    // Make the GoalsViewViewModel able to take data from firestore

    
    var body: some View {
        // Button to add new goal
        
        // Display new goal view when button pressed
        // New goals should be tied to habits,
        
        // Display all goals otherwise.
        
        // Goals are clickable. Clicking shows a sheet. includes progress,
        // connected habits,
        
        // Update progress is easy on goal.
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    // Present view with a test user
    GoalsView()
}
