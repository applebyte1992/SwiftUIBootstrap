//
//  AlertModifier.swift
//  QPharmaRx
//
//  Created by Masroor Elahi on 16/08/2022.
//

import Foundation
import SwiftUI

extension View {
    /// Error Alert
    /// - Parameters:
    ///   - error: error - App Error
    ///   - buttonTitle: Cancel Button Title
    /// - Returns: Return view
    func errorAlert(error: Binding<AppError?>, buttonTitle: String = "OK") -> some View {
        return alert(isPresented: .constant(error.wrappedValue != nil), error: error.wrappedValue) { _ in
            Button(buttonTitle) {
                error.wrappedValue = nil
            }
        } message: { error in
            Text(error.localizedDescription)
        }
    }
    func retryErrorAlert(error: Binding<AppError?>, buttonTitle: String = "OK", retryTitle: String = "Retry", retryAction:@escaping (() -> Void)) -> some View {
        return alert(isPresented: .constant(error.wrappedValue != nil), error: error.wrappedValue) { _ in
            Button(buttonTitle) {
                error.wrappedValue = nil
            }
            Button(retryTitle, action: retryAction)
        } message: { error in
            Text(error.localizedDescription)
        }
    }
}
