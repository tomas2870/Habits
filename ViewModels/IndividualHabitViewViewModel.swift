//
//  IndividualHabitViewViewModel.swift
//  Project
//
//  Created by Tomas Gonzalez on 12/2/23.
//

import Foundation

class IndividualHabitViewViewModel: ObservableObject {
    
    var habit: Habit
    
    init(habit: Habit) {
        self.habit = habit
    }
    
    var completed: Int {
        return habit.numberOfTimes - habit.numberOfTimesRemaining
    }
}
