//
//  Habit.swift
//  Project
//
//  Created by Tomas Gonzalez on 12/2/23.
//

import Foundation

// Define the structure of a habit
struct Habit: Codable, Identifiable {
    let id: String
    let title: String
    // Keep track of how many times someone should perform habit over the time period
    let numberOfTimes: Int
    // Keep track of the time period
    let frequency: String
    // Keep track of how many more times the person must do the habit within the alloted timeframe
    var numberOfTimesRemaining: Int
    // Keep track of day created
    var expirationDate: TimeInterval
    var isDone: Bool
    
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}
