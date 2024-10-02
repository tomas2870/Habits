//
//  SwiftUIView.swift
//  Project
//
//  Created by Tomas Gonzalez on 6/21/24.
//

import SwiftUI

struct ClearButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            // desired action
            action()
        } label: {
            
        }
    }
}

#Preview {
    ClearButton() {
        // Action
    }
}
