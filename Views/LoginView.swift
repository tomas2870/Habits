//
//  LoginView.swift
//  Project
//
//  Created by Tomas Gonzalez on 12/2/23.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HeaderView(title: "Atomic Habits", 
                           subtitle: "Change Your Life",
                           angle: 15,
                           background: .orange)
                
                // Login Form
                // Error message only displays if person does not fill out form properly
                Text(viewModel.errorMessage)
                    .bold()
                    .foregroundStyle(.red)
                Form {
                    TextField("Email Address", text: $viewModel.email)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    SecureField("Password", text: $viewModel.password)
                    
                    AHButton(title: "Log In", background: .orange) {
                        // Attempt login
                        viewModel.login()
                    }

                }
                .textFieldStyle(DefaultTextFieldStyle())
                
                
                // Registration link
                VStack {
                    Text("New around here?")
                    // Show registration
                    NavigationLink("Create An Account",
                                   destination: RegisterView())
                    .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
                .padding(.bottom, 30)
                .padding(.top, 10)
                
                Spacer()
            }
        }
        .accentColor(.black)
    }
}

#Preview {
    LoginView()
}
