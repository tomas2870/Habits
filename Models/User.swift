//
//  User.swift
//  Project
//
//  Created by Tomas Gonzalez on 12/2/23.
//

import Foundation

// Define the structure of a user
struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
