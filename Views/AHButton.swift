//
//  AHButton.swift
//  Project
//
//  Created by Tomas Gonzalez on 12/2/23.
//

import SwiftUI

struct AHButton: View {
    let title: String
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            // whatever action desired
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(background)
                    .frame(height: 35)
                
                Text(title)
                    .foregroundColor(.white)
                    .bold()
            }
        }
        .padding(1)
    }
}

#Preview {
    AHButton(title: "Default", background: .black) {
        // Action
    }
}
