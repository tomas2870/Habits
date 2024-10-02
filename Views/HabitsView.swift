//
//  HabitsView.swift
//  Project
//
//  Created by Tomas Gonzalez on 12/2/23.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

// GEt rid of commenting on the .onAppear thing

struct HabitsView: View {
    
    @StateObject var viewModel = HabitsViewViewModel()
    @FirestoreQuery var habits: [Habit]
        
    init(userId: String) {
        // Collect habits from database
        self._habits = FirestoreQuery(
            collectionPath: "users/\(userId)/habits"
        )
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)

                VStack {
                    // Shows all habits
                    List(habits) { habit in
                        IndividualHabitView(habit: habit)
                    }
                    .listStyle(.plain)
                    .padding(3)
                    .onAppear {
                        // Fetch data when the view appears
                        viewModel.fetchDataFromFirestore()
                    }
                }
                .navigationTitle("Home")
                // Button to add a new habit
                .toolbar {
                    Button {
                        // action
                        viewModel.newHabitViewShowing = true
                    } label: {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                    }
                    .padding(10)
                }
                .padding(10)
                .sheet(isPresented: $viewModel.newHabitViewShowing, content: {
                    NewHabitView(newHabitPresented: $viewModel.newHabitViewShowing)
                })
            }
        }
    }
}

#Preview {
    // Present view with a test user
    HabitsView(userId: "bPb9YERBeVM5ewMf5u7uAUcyfqu1")
}
