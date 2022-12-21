//
//  BaseViewModel.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 06/06/2022.
//

import Foundation
import SwiftUI
enum ViewModelStates: Equatable {
    static func == (lhs: ViewModelStates, rhs: ViewModelStates) -> Bool {
        switch(lhs,rhs) {
        case (.error, .error):
            return true
        case (.loaded, .loaded):
            return true
        case (.loading, .loading):
            return true
        default:
            return false
        }
    }
    case error
    case loading
    case loaded
}

class BaseViewModelClass: ObservableObject {
    @Published var viewState: ViewModelStates = .loaded
    @Published var error: AppError? {
        didSet {
            self.viewState = .error
        }
    }
    @MainActor
    func updateState(state: ViewModelStates) {
        self.viewState = state
    }
    @MainActor
    func handleError(error: AppError) {
        self.error = error
    }
}
