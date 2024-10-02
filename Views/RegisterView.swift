//
//  RegisterView.swift
//  Project
//
//  Created by Tomas Gonzalez on 12/2/23.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()
    
    
    var body: some View {
        VStack {
            // Header View
            HeaderView(title: "Register",
                       subtitle: "Start the Change",
                       angle: -15,
                       background: .blue)

            
            // Registration
            Text(viewModel.errorMessage)
                .bold()
                .foregroundStyle(.red)
            
            Form {
                TextField("Full Name", text: $viewModel.name)
                    .autocorrectionDisabled()
                
                TextField("Email", text: $viewModel.email)
                    .autocorrectionDisabled()
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                
                SecureField("Password", text: $viewModel.password)
                
                AHButton(title: "Register", background: .blue) {
                    // Attempt to register
                    viewModel.register()
                }
            }
            .textFieldStyle(DefaultTextFieldStyle())

            
            
            Spacer()
        }
        .offset(y: -45)
    }
}

#Preview {
    RegisterView()
}
