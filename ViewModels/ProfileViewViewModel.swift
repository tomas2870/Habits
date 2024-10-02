//
//  ProfileViewViewModel.swift
//  Project
//
//  Created by Tomas Gonzalez on 12/2/23.
//

import FirebaseAuth
import Foundation

class ProfileViewViewModel: ObservableObject {
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("Error")
        }
    }
}
