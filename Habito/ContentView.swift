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
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(habits.items) { habit in
                        HabitView(habit: habit, isEditing: $isEditing)
                            .padding(1)
                    }
                }
                Button("Edit") {
                    withAnimation {
                        isEditing.toggle()
                    }
                }
                .buttonStyle(.bordered)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .padding()
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
            .padding()
        }
    }
}

struct HabitView: View {
    
    let habit: Habit
    
    @State var deleteScale = 1.0
    
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            Text(habit.emoji)
                .font(.system(size: 50))
            VStack(alignment: .leading) {
                Text(habit.name)
                Text("Untill: \(habit.endString)")
            }
            Spacer()
            if isEditing {
                Image(systemName: "trash.fill")
                    .foregroundStyle(.red)
                    .scaleEffect(CGSize(width: deleteScale, height: deleteScale))
                    .onAppear {
                        animateButton()
                    }
                    .animation(.spring, value: deleteScale)
            } else {
                
            }
        }
        .padding()
        .frame(maxHeight: 200)
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .overlay {
            RoundedRectangle(cornerRadius: 25.0)
                .stroke(lineWidth: 1)
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
    
    let habits: Habits
    
    let calendar = Calendar.current
    @State private var emoji = "🏃🏻"
    @State private var name = ""
    @State private var compTarget = 1
    @State private var endDate = Date()
    @State private var description = ""
    @Environment(\.dismiss) var dismiss
    
    let emojis = ["🏃🏻", "🩲", "📕", "🏋🏻", "🎨"]
    var body: some View {
        NavigationStack {
            List {
                Picker("Pick an emoji", selection: $emoji) {
                    ForEach(emojis, id: \.self) { emoji in
                        Text(emoji)
                    }
                }
                TextField("Enter a name", text: $name)
                TextField("Enter a description", text: $description)
                Stepper("Completion target \(compTarget)", value: $compTarget, in: 1...999)
                DatePicker("Pick an end date", selection: $endDate, displayedComponents: [.date])
            }
            .toolbar {
                Button("Done") {
                    dismiss()
                    saveCurrent()
                }
            }
            .onAppear {
                endDate = fouruteenDays()
            }
            .navigationTitle("Create a new habit")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func fouruteenDays() -> Date {
        return calendar.date(byAdding: .day, value: 14, to: .now)!
    }
    
    func saveCurrent() {
        print("Saving...")
        habits.items.append(Habit(emoji: emoji, name: name, completionTarget: compTarget, endDate: endDate, description: description))
    }
    
}

#Preview {
    ContentView()
}
