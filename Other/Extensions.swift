//
//  Extensions.swift
//  Project
//
//  Created by Tomas Gonzalez on 12/3/23.
//

import Foundation

// SO that when I save things into firestore it's in the form of a dictionary
extension Encodable {
    func asDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return[:]
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        }
        catch {
            return [:]
        }
    }
}
