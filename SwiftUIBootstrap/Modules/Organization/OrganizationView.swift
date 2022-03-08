//  Created on 18/02/2022.

import SwiftUI

struct OrganizationView: View {
    
    var body: some View {
        
        CustomNavView {
            ZStack {
                Color.white.ignoresSafeArea()
                CustomNavLink(destination:
                                Text("detail screen")
                                .customNavigationTitle("detail screen title")
                ) {
                    Text("Organization view")
                    .font(.system(size: 40, weight: .bold, design: .default))
                }
            }
            .customNavBarItems(title: "Organizations", backButtonHidden: true)
        }
    }
}

struct OrganizationView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationView()
    }
}
