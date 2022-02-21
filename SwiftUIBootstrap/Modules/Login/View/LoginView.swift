//
//  LoginView.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 15/02/2022.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var loginViewModel = LoginViewModel()
    @State private var action: Int? = 0
    
    var body: some View {
        NavigationView{
        ZStack {
            Color.yellow
            //logo..
            VStack(spacing: 40) {
                VStack {
                    Text(Strings.SignIn.title)
                        .font(.largeTitle)
                    Text(Strings.SignIn.subtitle)
                        .font(.title2)
                    TextField(Strings.SignIn.emailAddress, text: $loginViewModel.username)
                        .keyboardType(.emailAddress)
                    SecureField(Strings.SignIn.password, text: $loginViewModel.password)
                    Button(Strings.Button.login) {
                        loginViewModel.login()
                    }
                    .disabled(!loginViewModel.isValid)
                    .padding(20)
                    
                    Button(action: {
                        self.action = 1
                    }, label: {
                        NavigationLink(destination: TabbarView(defaultView: .constant(1)).navigationBarBackButtonHidden(true), tag: 1, selection: $action) {
                             Text(Strings.Button.forgotPassword)
                         }
                    })
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
        .hiddenNavigationBarStyle()
        }.navigationViewStyle(StackNavigationViewStyle())
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
