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
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color._CFDEF3, Color._E0EAFC]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                // logo..
                VStack(spacing: 20) {
                    VStack {
                        // Headings
                        getHeader
                        // Feilds
                        getFields
                        // Actions
                       getActions
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 1)
                    .padding(.horizontal,10)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                }
                // Loader
                if loginViewModel.viewState == .loading {
                    LoaderView(message: "Loading")
                }
            }.errorAlert(error: $loginViewModel.error)
            .onDisappear {
                loginViewModel.dispose()
            }
            .hiddenNavigationBarStyle()
        }
    }
    // MARK: - Controls
    private var getHeader: some View {
        Group {
            getText(text: Strings.SignIn.title, font: .title)
            getText(text: Strings.SignIn.subtitle, font: .subheadline)
        }
    }
    private var getFields: some View {
        Group {
            TextField(Strings.SignIn.emailAddress, text: $loginViewModel.username)
                .keyboardType(.emailAddress)
                .padding(.horizontal, 8)
                .padding(.top , 8)
            SecureField(Strings.SignIn.password, text: $loginViewModel.password)
                .padding(.horizontal, 8)
                .padding(.top , 8)
        }
    }
    private var getActions: some View {
        Group {
            self.getActions(title: Strings.Button.login, action: self.actLogin)
                .disabled(!loginViewModel.isValid)
            self.getActions(title: Strings.SignIn.forgotPassword, action: self.navigateToForgotPassword)
        }
    }
    func getText(text: String , font: Font) -> some View {
        return Text(text)
            .font(font)
            .padding(.top,5)
            .multilineTextAlignment(.center)
    }
    func getActions(title: String , action : @escaping() -> Void) -> some View {
        return Button(title) {
            action()
        }
        .padding(20)
    }
    private func actLogin() {
        loginViewModel.login()
    }
    private func navigateToForgotPassword() {
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            LoginView()
        } else {
            // Fallback on earlier versions
        }
    }
}
