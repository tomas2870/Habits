//
//  LoginViewViewModel.swift
//  Project
//
//  Created by Tomas Gonzalez on 12/2/23.
//

import FirebaseAuth
import Foundation

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func login() {
        // Reset error message
        errorMessage = ""
        // Before logging in, validate
        guard validate() else {
            return
        }
        
        // Try login
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if authResult?.user != nil {
                return
            } 
            // if login didn't work
            else {
                // Display error message
                self.errorMessage = "Email or password was incorrect"
            }
        }
    }
    
    private func validate() -> Bool {
        // Reset error message every time function is called
        errorMessage = ""
        // Ensure both fields are filled out
        guard !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            // Give error message
            errorMessage = "Please enter an email and password."
            return false
        }
        // Ensure email is formatted correctly
        guard email.contains("@") && email.contains(".") else {
            // Give error message
            errorMessage = "Please enter a valid email."
            return false
        }
        return true
    }
}
