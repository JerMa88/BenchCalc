//
//  ExerciseView.swift
//  BenchCalc
//
//  Created by zma on 3/4/25.
//

import SwiftUI

class Exercises: ObservableObject {
    @Published var items: [Exercise]

    init() {
        self.items = [
            Exercise(exerciseName: "Leg Press", weight: 500, reps: 5, percentage: 80, restTime: 180),
            Exercise(exerciseName: "Squat", weight: 300, reps: 1, percentage: 100, restTime: 180),
            Exercise(exerciseName: "Calf Raise", weight: 0, reps: 10, percentage: 50, restTime: 180),
        ]
    }
}

struct ExerciseView: View {
    @ObservedObject var exercises = Exercises() // Inject the data
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(exercises.items) { exercise in
                    VStack(alignment: .leading) {
                        Text(exercise.exerciseName)
                            .font(.headline)
                        
                        Text("Weight: \(exercise.weight) lbs, Reps: \(exercise.reps)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Text("Rest Time: \(exercise.restTime) sec")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 5)
                }
            }
            .navigationTitle("Exercises")
        }
    }
}
