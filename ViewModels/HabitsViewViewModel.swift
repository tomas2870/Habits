//
//  HabitsViewViewModel.swift
//  Project
//
//  Created by Tomas Gonzalez on 12/2/23.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

class HabitsViewViewModel: ObservableObject {
    // Set condition as false initially
    @Published var newHabitViewShowing = false
    @Published var habits: [Habit] = []
    @Published var newExpirationDate = Date()
    
    init() {
        fetchDataFromFirestore()
    }

    private let db = Firestore.firestore()
    
    func fetchDataFromFirestore() {
        
        // Get user ID
        guard let uId = Auth.auth().currentUser?.uid else {
                 return
             }

        // Collect data from database
        db.collection("users").document(uId).collection("habits").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
            } else {
                if let documents = querySnapshot?.documents {
                    let habits = documents.compactMap { document -> Habit? in
                        do {
                            let habit = try document.data(as: Habit.self)
                            print("The data is there")
                            return habit
                        } catch {
                            print("Error decoding habit: \(error.localizedDescription)")
                            return nil
                        }
                    }
                    
                    // Filter and update the habits based on expiration date
                    self.updateHabitsWithExpirationDate(habits)
                }
            }
        }
    }
    
    // Update the habits expiration date when it expires
    private func updateHabitsWithExpirationDate(_ habits: [Habit]) {
        
        let currentDate = Date().timeIntervalSince1970
        
        // Get user ID
        guard let uId = Auth.auth().currentUser?.uid else {
                 return
             }
        
        // Update habits based on expiration date
        var updatedHabits: [Habit] = []
        var id = ""
        
        // Check all habits and see if they need to be changed
        for habit in habits {
            // Determine expiration date based on chosen frequency
            if habit.frequency == "Day" {
                newExpirationDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
            }
            else if habit.frequency == "Week" {
                newExpirationDate = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
            }
            // Set the expiration date to midnight of whatever day it is:
            newExpirationDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: newExpirationDate)!
            
            id = habit.id
            let expirationDate = habit.expirationDate
            if expirationDate <= currentDate {
                // If expiration date is equal to today or more than today, set numberOfTimesRemaining to numberOfTimes
                // Also set the new expiration date
                print("You should change the date!")
                db.collection("users")
                    .document(uId)
                    .collection("habits")
                    .document(id)
                    .updateData([
                        "numberOfTimesRemaining": habit.numberOfTimes,
                        "expirationDate": newExpirationDate.timeIntervalSince1970
                                ])
            }
            updatedHabits.append(habit)
        }

        // Update the @Published property to trigger view updates
        DispatchQueue.main.async {
            self.habits = updatedHabits
        }
    }
    
    // Complete habit
    func completeHabit(_ id: String, _ timesRemaining: Int) {
        // Get user ID
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        // Update document by incrementing times completed by 1
        db.collection("users")
            .document(uId)
            .collection("habits")
            .document(id)
            .updateData([
                "numberOfTimesRemaining": FieldValue.increment(Int64(-1))
                        ])
    }
}
