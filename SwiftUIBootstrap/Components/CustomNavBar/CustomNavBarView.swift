//  Created on 02/03/2022.

import SwiftUI

struct CustomNavBarView: View {
    
    @Environment(\.presentationMode) var presentationMode
    let showBackButton: Bool
    let title: String
    let subtitle: String?
    var body: some View {
            HStack {
                if showBackButton {
                    backButton
                }
                titleSection
                Spacer()
                buttonsView
            }
            .padding()
            .accentColor(.white)
            .foregroundColor(.white)
            .font(.headline)
            .background(
                Color.blue.ignoresSafeArea(edges: .top)
            )
            .overlay(
                logo
                , alignment: .center
            )
        }
}

extension CustomNavBarView {
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
        })
    }
    
    private var titleSection: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
            if let subtitle = subtitle {
                Text(subtitle)
            }
        }
    }
    
    private var logo: some View {
        Text("logo")
            .font(.title)
            .frame(height: 100)
            .foregroundColor(.white)
    }
    
    private var buttonsView: some View {
        Text("button content")
            .foregroundColor(.white)
    }
}

struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            VStack {
                CustomNavBarView(showBackButton: true, title: "Title here", subtitle: nil)
                Spacer()
            }
            .previewInterfaceOrientation(.landscapeLeft)
        } else {
            // Fallback on earlier versions
        }
    }
}
