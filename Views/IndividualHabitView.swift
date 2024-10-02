//
//  IndividualHabitView.swift
//  Project
//
//  Created by Tomas Gonzalez on 12/2/23.
//

import SwiftUI

// As I continue to buid my project I'll move a lot of habit view into here, and then just display the list on habitview by using this view within habit view
struct IndividualHabitView: View {
    
    @StateObject var viewModel = HabitsViewViewModel()
    
    var habit: Habit
    
    init(habit: Habit) {
        self.habit = habit
    }
    
    var body: some View {
        HStack{
            Button{
                // Complete habit
                viewModel.completeHabit(habit.id, habit.numberOfTimesRemaining)
            } label: {
                ZStack {
                    Image("Atom Textbox")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
                    VStack{
                        Text(habit.title)
                            .font(.custom("Kailasa", fixedSize: 24))
                        if habit.frequency == "Day" {
                            Text(String(habit.numberOfTimes - habit.numberOfTimesRemaining) + "/" + String(habit.numberOfTimes) + " Today")
                                .font(Font.system(size: 20))
                        }
                        else if habit.frequency == "Week" {
                            Text(String(habit.numberOfTimes - habit.numberOfTimesRemaining) + "/" + String(habit.numberOfTimes) + " This Week")
                                .font(Font.system(size: 20))
                        }
                    }
                    ClearButton{
                        viewModel.completeHabit(habit.id, habit.numberOfTimesRemaining)
                    }
                }
            }
            .frame(maxHeight: UIScreen.main.bounds.width * 0.8)
        }
        .listRowSeparator(.hidden)

    }
        
    
//    var body: some View {
//            HStack {
//                VStack {
//                    Text(habit.title)
//                        .font(.custom(
//                            "Kailasa", fixedSize: 24))
//                    if habit.frequency == "Day" {
//                        Text(String(habit.numberOfTimes - habit.numberOfTimesRemaining)
//                             + "/" + String(habit.numberOfTimes) + " Today")
//                        .font(Font.system(size: 20))
//                    }
//                    else {
//                        Text(String(habit.numberOfTimes - habit.numberOfTimesRemaining)
//                             + "/" + String(habit.numberOfTimes) + " This week")
//                        .font(Font.system(size: 20))
//                    }
//                }
//                .padding(3)
//                
//                Spacer()
//               AHButton(title: "Complete", background: .green) {
//                   // Complete habit
//                   viewModel.completeHabit(habit.id, habit.numberOfTimesRemaining)
//               }
//                .frame(maxWidth: UIScreen.main.bounds.width*1/4)
//                .padding(3)
//                .buttonStyle(BorderlessButtonStyle())
//            }
//            // This will display errors here but since it will be displayed in a list, the errors will go away. If you need to edit the view, comment out the next two list modifiers and a preview will be available
//            .listRowSeparator(.hidden)
//            .listRowBackground(
//                RoundedRectangle(cornerRadius: 12)
//                    .fill(Color.gray)
//                    .opacity(0.3)
//                    .padding(10)
//            )
//    }
    
}

#Preview {
    IndividualHabitView(habit: Habit(id: "test", title: "Test", numberOfTimes: 4, frequency: "Day", numberOfTimesRemaining: 2, expirationDate: 1, isDone: false))
}
