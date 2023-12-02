//
//  HabitClass.swift
//  Habito
//
//  Created by Maks Winters on 02.12.2023.
//

import Foundation

class Habit: Identifiable {
    var id = UUID()
    var emoji: String
    var name: String
    var startDate = Date()
    var completedTimes = 0
    var completionTarget: Int
    var endDate: Date
    
    var startString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YY"
        return dateFormatter.string(from: startDate)
    }
    
    var endString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YY"
        return dateFormatter.string(from: startDate)
    }
    
    var description: String
    
    init(emoji: String, name: String, completionTarget: Int, endDate: Date, description: String) {
        self.emoji = emoji
        self.name = name
        self.completionTarget = completionTarget
        self.endDate = endDate
        self.description = description
    }
}

@Observable
class Habits {
    var items = [
        Habit(emoji: "🏃🏻", name: "Running", completionTarget: 10, endDate: Date(), description: "Run everyday"),
        Habit(emoji: "🩲", name: "Swimming", completionTarget: 10, endDate: Date(), description: "Swim every week"),
        Habit(emoji: "📕", name: "Learning", completionTarget: 10, endDate: Date(), description: "Study everyday"),
        Habit(emoji: "🏋🏻", name: "Workout", completionTarget: 10, endDate: Date(), description: "Workout every two days")
    ]
}
