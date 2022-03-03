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
                Text("Content")
            }
            .padding()
            .accentColor(.white)
            .foregroundColor(.white)
            .font(.headline)
            .background(
                Color.blue.ignoresSafeArea(edges: .top)
            )
            .overlay(
                Text("logo")
                    .foregroundColor(.white)
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
