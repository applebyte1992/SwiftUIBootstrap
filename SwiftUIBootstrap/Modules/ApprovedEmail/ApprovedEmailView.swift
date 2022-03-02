//  Created on 18/02/2022.

import SwiftUI

struct ApprovedEmailView: View {
    var body: some View {
        CustomNavView {
            ZStack {
                Color.white.ignoresSafeArea()
                
                CustomNavLink(destination:
                                Text("detail screen")
                                .customNavigationTitle("detail screen title")
                ) {
                    Text("Approved email content")
                    .font(.system(size: 40, weight: .bold, design: .default))
                }
            }
            .customNavBarItems(title: "Approved Email", backButtonHidden: true)
        }
    }
}

struct ApprovedEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ApprovedEmailView()
    }
}
