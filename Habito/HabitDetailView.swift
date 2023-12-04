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
                CustomDividerView()
                ProgressBarView(progress: Double(habit.completedTimes), total: Double(habit.completionTarget))
                    .padding()
                CustomDividerView()
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(String(habit.completedTimes))
                            Button("+") { 
                                habit.completedTimes += 1
                                habits.saveItself()
                            }
                                .buttonStyle(.bordered)
                                .tint(.white)
                                .clipShape(Circle())
                                .frame(width: 35, height: 35)
                            Button("-") {
                                habit.completedTimes -= 1
                                habits.saveItself()
                            }
                                .buttonStyle(.bordered)
                                .tint(.white)
                                .clipShape(Circle())
                                .frame(width: 35, height: 35)
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
}

#Preview {
    HabitDetailView(habits: Habits(), habit: Habit(emoji: "🩲", name: "Swimming", completionTarget: 10, endDate: Date(), description: "Swim every week"))
}
