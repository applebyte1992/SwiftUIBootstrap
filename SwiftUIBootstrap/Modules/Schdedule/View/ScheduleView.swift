//  Created on 18/02/2022.

import SwiftUI

struct ScheduleView: View {
    var body: some View {
        
        CustomNavView {
            ZStack {
                Color.white.ignoresSafeArea()
                
                CustomNavLink(destination:
                                Text("Second Screen")
                                .customNavigationTitle("Second Screen title")
                ) {
                    Text("Schedule view")
                        .font(.system(size: 40, weight: .bold, design: .default))                }
            }
            .customNavBarItems(title: "Schedule", subtitle: nil, backButtonHidden: true)
        }
        
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            ScheduleView()
                .previewInterfaceOrientation(.landscapeRight)
        } else {
            // Fallback on earlier versions
        }
    }
}
