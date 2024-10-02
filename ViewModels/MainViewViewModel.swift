//
//  MainViewViewModel.swift
//  Project
//
//  Created by Tomas Gonzalez on 12/2/23.
//

import FirebaseAuth
import Foundation

class MainViewViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    // Verify if someone is signed in
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
