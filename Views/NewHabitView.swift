//
//  NewHabitView.swift
//  Project
//
//  Created by Tomas Gonzalez on 12/2/23.
//

import SwiftUI

struct NewHabitView: View {
    @StateObject var viewModel = NewHabitsViewViewModel()
    @Binding var newHabitPresented: Bool
    
    var body: some View {
        VStack {
            
            Text("New Habit")
                .bold()
                .font(.system(size: 32))
                .padding(.top)
            // Collects the data for a habit
            // TODO: implement in-line error messages
            Form {
                // Name of habit
                HStack {
                    Text("Name of Habit: ")
                        .bold()
                    TextField("", text: $viewModel.title)
                        .textFieldStyle(DefaultTextFieldStyle())
                }
                HStack {
                    Text("\(viewModel.numberOfTimes)")
                        .foregroundStyle(.red)
                        .bold()
                        .underline()
                    Picker(selection: $viewModel.frequency,
                           label: Text("time(s) per ").bold()) {
                        ForEach(viewModel.frequencyOptions, id: \.self) {
                            Text($0)
                        }
                        .onChange(of: viewModel.frequency) { newFrequency in
                            self.viewModel.didChange(newFrequency)
                        }
                    }
                    Stepper("",
                            value: $viewModel.numberOfTimes,
                            in: 0...14,
                            step: 1)
                    .frame(maxWidth: UIScreen.main.bounds.width*7/24)
                }
                .lineLimit(1)
                // Button to save the new habit
                AHButton(title: "Create", background: .green) {
                    // Create new habit
                    if viewModel.canSave {
                        viewModel.save()
                        // Close new habit screen
                        newHabitPresented = false
                    }
                    // Ensures that it works ya know and displays an error if it's not properly filled out
                    else {
                        viewModel.showAlert = true
                    }
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert (
                    title: Text("Error"),
                    message: Text("Please fill out all fields."))
            }
        }
    }
}

#Preview {
    NewHabitView(newHabitPresented: Binding(get: {
        return true
    }, set: { _ in
    }))
}
