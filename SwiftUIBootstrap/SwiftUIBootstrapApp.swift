//
//  SwiftUIBootstrapApp.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 15/02/2022.
//

import SwiftUI

@main
struct SwiftUIBootstrapApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            TabbarView(defaultView: .constant(1))//LoginView()
        }
    }
}
