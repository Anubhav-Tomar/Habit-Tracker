//
//  HabitCalendarView.swift
//  Habit Tracker
//
//  Created by Anubhav Tomar on 28/01/25.
//

import SwiftUI

struct HabitCalendarView: View {
    
    var isDemo: Bool = false
    var createdAt: Date
    var frequencies: [Frequency]
    var completedDates: [TimeInterval]
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 12) {
            if !isDemo {
                ForEach(Frequency.allCases, id: \.rawValue) { frequency in
                    Text(frequency.rawValue.prefix(3))
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
            
            ForEach(0..<Date.startOfSetOfThisMonth, id: \.self) { _ in
                Circle()
                    .fill(.clear)
                    .frame(height: 30)
                    .hSpacing(.center)
            }
            
            ForEach(Date.datesInThisMonth, id: \.self) { date in
                let day = date.format("dd")
                
                Text(day)
                    .font(.caption)
                    .frame(height: 30)
                    .hSpacing(.center)
                    .background {
                        let isHabitCompleted = completedDates.contains {
                            $0 == date.timeIntervalSince1970
                        }
                        
                        let isHabitDay = frequencies.contains {
                            $0.rawValue == date.weekDay
                        } && date.startOfDay >= createdAt.startOfDay
                        
                        let isFutureHabits = date.startOfDay > Date()
                        
                        if isHabitCompleted && isHabitDay && !isDemo {
                            Circle()
                                .fill(.green.tertiary)
                        } else if isHabitDay && !isFutureHabits && !isDemo {
                            Circle()
                                .fill((date.isToday ? Color.yellow : Color.red).tertiary)
                        } else {
                            if isHabitDay {
                                Circle()
                                    .fill(.fill)
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    HabitCalendarView(createdAt: .now, frequencies: [.sunday, .monday], completedDates: [])
}
