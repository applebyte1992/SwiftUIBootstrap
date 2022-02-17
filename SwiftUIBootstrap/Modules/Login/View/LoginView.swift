//
//  LoginView.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 15/02/2022.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var loginViewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            Color.yellow
            //logo..
            VStack(spacing: 40) {
                VStack {
                    Text("Sign In")
                        .font(.largeTitle)
                    Text("Please log in to access your account")
                        .font(.title2)
                    TextField("Email Address", text: $loginViewModel.username)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $loginViewModel.password)
                    Button("Log in") {
                        loginViewModel.login()
                    }
                    .disabled(!loginViewModel.isValid)
                    .padding(20)
                    Button("Forgot Password?") {
                        
                    }
                }
                .padding(50)
                .frame(maxWidth: 500, alignment: .center)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color.yellow)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            LoginView()
                .previewInterfaceOrientation(.landscapeLeft)
        } else {
            // Fallback on earlier versions
        }
    }
}
