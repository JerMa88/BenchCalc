//
//  Exercise.swift
//  BenchCalc
//
//  Created by zma on 3/4/25.
//

import Foundation
import SwiftUI

struct Exercise: Identifiable {
    var id = UUID()
    var exerciseName: String
    var weight: Int
    var reps: Int
    var percentage: Int
    var restTime: Int
    
    init(id: UUID = UUID(), exerciseName: String, weight: Int, reps: Int, percentage: Int, restTime: Int) {
        self.id = id
        self.exerciseName = exerciseName
        self.weight = weight
        self.reps = reps
        self.percentage = percentage
        self.restTime = restTime
    }
}

struct ExerciseView: View {
    var exercises: [Exercise]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(exercises) { exercise in
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
