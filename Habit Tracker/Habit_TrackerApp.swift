//
//  Habit_TrackerApp.swift
//  Habit Tracker
//
//  Created by Anubhav Tomar on 28/01/25.
//

import SwiftUI

@main
struct Habit_TrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Habit.self)
        }
    }
}
