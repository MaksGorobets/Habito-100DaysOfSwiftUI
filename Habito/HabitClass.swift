//
//  HabitClass.swift
//  Habito
//
//  Created by Maks Winters on 02.12.2023.
//

import Foundation

@Observable
class Habit: Identifiable, Codable, Equatable, Hashable {
    
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: UUID
    let emoji: String
    let name: String
    let startDate: Date
    var completedTimes = 0
    let completionTarget: Int
    let endDate: Date
    
    var startString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YY"
        return dateFormatter.string(from: startDate)
    }
    
    var endString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YY"
        return dateFormatter.string(from: endDate)
    }
    
    var description: String
    
    init(id: UUID = UUID(), emoji: String, name: String, startDate: Date = Date(), completionTarget: Int, endDate: Date, description: String) {
        self.id = id
        self.emoji = emoji
        self.name = name
        self.startDate = startDate
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
    ] { didSet {
        if let newData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(newData, forKey: "Expenses")
        }
    }}
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "Expenses") {
            if let decodedData = try? JSONDecoder().decode([Habit].self, from: data) {
                items = decodedData
                return
            }
        }
        items = [
            Habit(emoji: "🏃🏻", name: "Running", completionTarget: 10, endDate: Date(), description: "Run everyday"),
            Habit(emoji: "🩲", name: "Swimming", completionTarget: 10, endDate: Date(), description: "Swim every week"),
            Habit(emoji: "📕", name: "Learning", completionTarget: 10, endDate: Date(), description: "Study everyday"),
            Habit(emoji: "🏋🏻", name: "Workout", completionTarget: 10, endDate: Date(), description: "Workout every two days")
        ]
    }
    
    func saveItself() {
        if let newData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(newData, forKey: "Expenses")
        }
    }
    
    func removeItem(habit: Habit) {
        if let index = items.firstIndex(where: { $0.id == habit.id }) {
            items.remove(at: index)
        } else {
            print("No match")
        }
        print(items.count)
    }
    
}
