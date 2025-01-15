//
//  Loadingview.swift
//  WeatherApp
//
//  Created by Tayyip Güzel on 14.01.2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(2)
                .frame(width: 100, height: 100)
                .padding()
        }
    }
}

#Preview {
    LoadingView()
}
