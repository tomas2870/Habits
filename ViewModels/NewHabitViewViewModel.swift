//
//  NewHabitViewViewModel.swift
//  Project
//
//  Created by Tomas Gonzalez on 12/2/23.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class NewHabitsViewViewModel: ObservableObject {
    @Published var title = ""
    @Published var errorMessage = ""
    @Published var showAlert = false
    @Published var numberOfTimes: Int = 1
    @Published var frequency: String = "Day"
    @Published var numberOfTimesRemaining = 0
    @Published var expirationDate = Date()
    var frequencyOptions = ["Day", "Week"]
    
    init() {}
    
    func save() {
        guard canSave else {
            return
        }
        
        // Get current user id
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        // Determine expiration date based on chosen frequency
        if frequency == "Day" {
            expirationDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        }
        else if frequency == "Week" {
            expirationDate = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
        }
        // Set the expiration date to midnight of whatever day it is:
        expirationDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: expirationDate)!
                
        // Create model
        let newId = UUID().uuidString
        let newHabit = Habit(
            id: newId,
            title: title,
            numberOfTimes: numberOfTimes,
            frequency: frequency,
            numberOfTimesRemaining: numberOfTimes,
            expirationDate: expirationDate.timeIntervalSince1970,
            isDone: false)
        
        // Save model
        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("habits")
            .document(newId)
            .setData(newHabit.asDictionary())
    }
    
    // Check the frequency of habit
    func didChange(_ newFrequency: String) {
        if newFrequency == "Day" {
            // Do something for daily frequency
            print("Daily selected")
        } else if newFrequency == "Week" {
            // Do something for weekly frequency
            print("Weekly selected")
        }
        // You can also perform other actions or update other properties in your view model
    }
    
    var canSave: Bool {
        // Reset error message
        errorMessage = ""
        
        // Ensure that there is text written in the title of the habit
        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }
        return true
    }
}
