//
//  RegisterViewViewModel.swift
//  Project
//
//  Created by Tomas Gonzalez on 12/2/23.
//
import FirebaseFirestore
import FirebaseAuth
import Foundation

class RegisterViewViewModel: ObservableObject{
    @Published var name = ""
    @Published var email = ""
    @Published var password  = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func register() {
        // Reset error message
        errorMessage = ""
        
        guard validate() else {
            return
        }
        
        // Attempt to register account
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let userId = result?.user.uid else {
                // If registration didn't work, provide error message
                self?.errorMessage = "Registration Failed"
                return
            }
            // Insert account into records
            self?.insertUserRecord(id: userId)
        }
        
        
    }
    
    // Inserts records
    private func insertUserRecord(id: String) {
        let newUser = User(id: id,
                           name: name,
                           email: email,
                           joined: Date().timeIntervalSince1970)
        // Uses firestore to insert
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    private func validate() -> Bool {
        // Reset error message
        errorMessage = ""
        // Ensure name, email, and password are all filled out
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            // Give error message
            errorMessage = "Please fill out all fields."
            return false
        }
        
        // Ensure password is at least 8 characters long
        guard password.count >= 8 else {
            // Error message
            errorMessage = "Password must be at least 8 characters."
            return false
        }
        
        return true
    }
}
