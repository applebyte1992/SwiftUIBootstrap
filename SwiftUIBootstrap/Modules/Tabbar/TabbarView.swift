//  Created on 18/02/2022.

import SwiftUI

struct TabbarView: View {
    
    @Binding var defaultView : Int
    
    var body: some View {
        TabView(selection: $defaultView){
            ScheduleView()
                .tabItem {
                    Text("Schedule")
                    Image(systemName: "house")
                }.tag(0)
            
            AccountView()
                .tabItem {
                    Text("Account")
                    Image(systemName: "magnifyingglass")
                }.tag(1)
            
            OrganizationView()
                .tabItem {
                    Text("Organization")
                    Image(systemName: "play")
                }.tag(2)
            
            ApprovedEmailView()
                .tabItem {
                    Text("Approved Email")
                    Image(systemName: "pencil")
                }.tag(3)
        }//.accentColor(.blue) to change the selection color of the tab
    }
    
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView(defaultView: .constant(1))
    }
}
