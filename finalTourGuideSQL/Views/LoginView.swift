//
//  LoginView.swift
//  finalTourGuideSQL
//
//  Created by KENK on 2024/3/27.
//

import SwiftUI

struct LoginView: View {
    @State private var credentials = Credentials(username: "", password: "")
    @State private var isUserLoggedIn = false
    @State private var showingLoginError = false

    var body: some View {
        NavigationView {
            VStack {
                if isUserLoggedIn {
                    SQLToggleView()
                } else {
                    TextField("Username", text: $credentials.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    SecureField("Password", text: $credentials.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    if showingLoginError {
                        Text("错误：用户名或密码不正确")
                            .foregroundColor(.red)
                    }
                    
                    Button("登录") {
                        if isValidUser(credentials: credentials) {
                            isUserLoggedIn = true
                        } else {
                            showingLoginError = true
                            // Optionally reset the password field
                            credentials.password = ""
                        }
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
                }
            }
        }
    }
    
    func isValidUser(credentials: Credentials) -> Bool {
        if credentials.username == "admin" && credentials.password == "password" {
            showingLoginError = false
            return true
        } else {
            return false
        }
    }
}

#Preview {
    LoginView()
}
