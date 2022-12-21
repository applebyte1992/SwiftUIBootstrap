//
//  LoaderView.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 21/05/2022.
//

import SwiftUI

struct LoaderView: View {
    var message: String = "Loading"
    var body: some View {
        ZStack(alignment: .center) {
            Color.clear
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack(alignment: .leading) {
                ProgressView {
                    Text(message)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(width: 100, height: 100, alignment: .center)
            .background(.thickMaterial, in: RoundedRectangle(cornerRadius: 10))
        }
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView(message: "Loading Data")
            .padding()
    }
}
