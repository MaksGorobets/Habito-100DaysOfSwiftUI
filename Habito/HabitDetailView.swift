//
//  HabitDetailView.swift
//  Habito
//
//  Created by Maks Winters on 04.12.2023.
//

import SwiftUI

struct HabitDetailView: View {
    
    @State var habits: Habits
    @State var habit: Habit
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                mainTitle()
                CustomDividerView()
                ProgressBarView(progress: Double(habit.completedTimes), total: Double(habit.completionTarget))
                    .padding()
                CustomDividerView()
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(String(habit.completedTimes))
                                .contentTransition(.numericText(value: Double(habit.completedTimes)))
                            addCompletionButton()
                            subtractCompletionButton()
                        }
                        Text("Completed")
                    }
                    .font(.system(size: 25))
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(String(habit.completionTarget))
                            .frame(width: 35, height: 35)
                        Text("Left")
                    }
                    .font(.system(size: 25))
                }
                .padding()
                CustomDividerView()
                VStack {
                    Text("About")
                    Text(habit.description)
                }
                Spacer()
            }
        }
        .background(.blue.gradient)
        .preferredColorScheme(.dark)
        .navigationTitle("Info")
    }
    
    func addCompletionButton() -> some View {
        Button("+") {
            withAnimation {
                habit.completedTimes += 1
                habits.saveItself()
            }
        }
        .sensoryFeedback(.increase, trigger: habit.completedTimes)
        .buttonStyle(.bordered)
        .tint(.white)
        .clipShape(Circle())
        .frame(width: 35, height: 35)
    }
    
    func subtractCompletionButton() -> some View {
        Button("-") {
            withAnimation {
                habit.completedTimes -= 1
                habits.saveItself()
            }
        }
        .disabled(habit.completedTimes == 0)
        .sensoryFeedback(.decrease, trigger: habit.completedTimes)
        .buttonStyle(.bordered)
        .tint(.white)
        .clipShape(Circle())
        .frame(width: 35, height: 35)
    }
    
    func mainTitle() -> some View {
        VStack {
            HStack {
                Text(habit.emoji)
                    .font(.system(size: 120))
                    .shadow(color: .white, radius: 5)
                Text(habit.name)
                    .font(.system(size: 30, design: .serif))
                    .padding()
            }
            HStack {
                Text("\(habit.startString) - \(habit.endString)")
            }
        }
        .padding()
    }
    
}

#Preview {
    HabitDetailView(habits: Habits(), habit: Habit(emoji: "🩲", name: "Swimming", completionTarget: 10, endDate: Date(), description: "Swim every week"))
}
