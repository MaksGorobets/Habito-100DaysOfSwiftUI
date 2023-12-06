//
//  ContentView.swift
//  Habito
//
//  Created by Maks Winters on 02.12.2023.
//

import SwiftUI

struct ContentView: View {
    
    let calendar = Calendar.current
    
    @State private var isPresented = false
    
    @State var isEditing = false
    
    let habits = Habits()
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                ForEach(habits.items) { habit in
                    NavigationLink(value: habit) {
                        LazyVStack {
                            HabitView(habit: habit, habits: habits, isEditing: $isEditing)
                                .padding(1)
                        }
                    }
                    .foregroundStyle(.white)
                }
                Button("Edit", role: .destructive) {
                    withAnimation {
                        isEditing.toggle()
                    }
                }
                .buttonStyle(.borderedProminent)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .padding()
            }
            .navigationDestination(for: Habit.self) { habit in
                HabitDetailView(habits: habits, habit: habit)
            }
            .toolbar {
                Button {
                    isPresented.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isPresented) {
                SheetView(habits: habits)
                    .presentationBackground(.ultraThinMaterial)
                    .presentationDetents([.medium])
            }
            .navigationTitle("Habito")
            .padding(.horizontal)
            .containerRelativeFrame(.horizontal, { width, axis in
                width
            })
            .background(.blue.gradient)
            .preferredColorScheme(.dark)
        }
        .scrollIndicators(.hidden)
    }
}

struct HabitView: View {

    let habit: Habit
    
    @State var deleteScale = 1.0
    let habits: Habits
    
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            Text(habit.emoji)
                .font(.system(size: 50))
                .shadow(color: .white, radius: 2)
            VStack(alignment: .leading) {
                Text("\(habit.name) (\(habit.completedTimes) / \(habit.completionTarget))")
                Text("Untill: \(habit.endString)")
            }
            Spacer()
            if isEditing {
                editButton()
            } else {
                
            }
        }
        .padding()
        .frame(maxHeight: 200)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .overlay {
            RoundedRectangle(cornerRadius: 25.0)
                .stroke(lineWidth: 1)
        }
    }
    
    func editButton() -> some View {
        Button {
            withAnimation {
                habits.removeItem(habit: habit)
            }
        } label: {
            Image(systemName: "trash.fill")
                .foregroundStyle(.red)
                .scaleEffect(CGSize(width: deleteScale, height: deleteScale))
                .shadow(color: .white, radius: 1)
                .onAppear {
                    animateButton()
                }
                .animation(.spring, value: deleteScale)
        }
    }
    
    func animateButton() {
        print("Did set")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            deleteScale = 1.5
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            deleteScale = 1.0
        }
    }
}

struct SheetView: View {
    
    static var fourteenDays: Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: 14, to: .now)!
    }
    
    let habits: Habits
    
    @State private var emoji = "🏃🏻"
    @State private var name = ""
    @State private var compTarget = 1
    @State var endDate = fourteenDays
    @State private var description = ""
    @Environment(\.dismiss) var dismiss
    
    let emojis = ["🏃🏻", "🩲", "📕", "🏋🏻", "🎨"]
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Pick an emoji:")
                    Picker("Pick an emoji", selection: $emoji) {
                        ForEach(emojis, id: \.self) { emoji in
                            Text(emoji)
                        }
                    }
                }
                TextField("Enter a name", text: $name)
                TextField("Enter a description", text: $description)
                Stepper("Completion target \(compTarget)", value: $compTarget, in: 1...999)
                DatePicker("Pick an end date", selection: $endDate, displayedComponents: [.date])
            }
            .padding()
            .toolbar {
                Button("Done") {
                    dismiss()
                    saveCurrent()
                }
            }
            .navigationTitle("Create a new habit")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func saveCurrent() {
        print("Saving...")
        guard name != "" else { return }
        habits.items.append(Habit(emoji: emoji, name: name, completionTarget: compTarget, endDate: endDate, description: description))
    }
    
}

#Preview {
    ContentView()
}
