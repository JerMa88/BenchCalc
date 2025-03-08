//
//  ExerciseView.swift
//  BenchCalc
//
//  Created by zma on 3/4/25.
//

import SwiftUI

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
