//
//  ContentView.swift
//  Habit Tracker
//
//  Created by Anubhav Tomar on 28/01/25.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("isIntroCompleted") private var isIntroCompleted: Bool = false
    
    var body: some View {
        ZStack {
            if isIntroCompleted {
                NavigationStack {
                    Home()
                }
                .transition(.move(edge: .trailing))
            } else {
                IntroPageView()
                .transition(.move(edge: .leading))
            }
        }
        .animation(.snappy(duration: 0.25, extraBounce: 0), value: isIntroCompleted)
    }
}

#Preview {
    ContentView()
}
