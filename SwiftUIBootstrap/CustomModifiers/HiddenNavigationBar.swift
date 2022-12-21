//  Created on 21/02/2022.

import SwiftUI

struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

extension View {
    func hiddenNavigationBarStyle() -> some View {
        modifier( HiddenNavigationBar() )
    }
}

private struct FrameModifier: ViewModifier {
    let height: CGFloat?
    let width: CGFloat?
    func body(content: Content) -> some View {
        content
            .frame(width: width, height: height)
    }
}

extension View {
    func height(_ height: CGFloat) -> some View {
        modifier(FrameModifier(height: height, width: nil))
    }
    func width(_ width: CGFloat) -> some View {
        modifier(FrameModifier(height: nil, width: width))
    }
}
