//  Created on 18/02/2022.

import SwiftUI

struct AccountView: View {
    var body: some View {
        
        CustomNavView {
            ZStack {
                
                CustomNavLink(destination:
                                Text("Second Screen")
                                .customNavigationTitle("Second Screen title")
                ) {
                    Text("Accounts view")
                    .font(.system(size: 40, weight: .bold, design: .default))
                    
                }
            }
            .customNavBarItems(title: "Accounts", backButtonHidden: true) //by default back button is visible
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
