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
        case (let .error(lhsString), let .error(rhsString)):
            return lhsString.localizedDescription == rhsString.localizedDescription
        case (.loaded, .loaded):
            return true
        case (.loading, .loading):
            return true
        default:
            return false
        }
    }
    case error(Error)
    case loading
    case loaded
}

class BaseViewModelClass: ObservableObject {
    @Published var viewState: ViewModelStates = .loaded
}
