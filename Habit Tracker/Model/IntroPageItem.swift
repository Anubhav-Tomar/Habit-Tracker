//
//  IntroPageItem.swift
//  Habit Tracker
//
//  Created by Anubhav Tomar on 28/01/25.
//

import SwiftUI

struct IntroPageItem: Identifiable {
    var id: String = UUID().uuidString
    var image: String
    var title: String
    
    var scale: CGFloat = 1
    var anchor: UnitPoint = .center
    var offset: CGFloat = 0
    var rotaion: CGFloat = 0
    var zindex: CGFloat = 0
    
    var extraOffset: CGFloat = -350
    var description: String
}

// Intro page items
let staticIntroItems: [IntroPageItem] = [
    .init(image: "calendar.circle.fill",
          title: "Track your daily\nhabits",
          scale: 1,
          description: "Keep track of your daily habits and\nsee how much you can improve."
         ),
    .init(image: "checkmark.circle.fill",
          title: "Stay consistent and\nbuild routines",
          scale: 0.6,
          anchor: .topLeading,
          offset: -70,
          rotaion: 30,
          description: "Form habits that stick by marking\noff tasks and staying consistent each day."
         ),
    .init(image: "star.circle.fill",
          title: "Celebrate your\nsmall wins",
          scale: 0.5,
          anchor: .bottomLeading,
          offset: -60,
          rotaion: -35,
          description: "Celebrate milestones to stay\nmotivated and recognize your progress."
         ),
    .init(image: "flame.circle.fill",
          title: "Stay motivated\nevery day",
          scale: 0.4,
          anchor: .bottomLeading,
          offset: -50,
          rotaion: 160,
          extraOffset: -120,
          description: "Track streaks and use visual progress\nto stay inspired and motivated."
         ),
    .init(image: "clock.circle.fill",
          title: "Track your time\nand progress",
          scale: 0.35,
          anchor: .bottomLeading,
          offset: -50,
          rotaion: 250,
          extraOffset: -100,
          description: "Form habits that stick by marking\noff tasks and staying consistent each day."
         ),
]
