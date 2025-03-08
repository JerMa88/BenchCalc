//
//  Workout.swift
//  BenchCalc
//
//  Created by zma on 3/4/25.
//

import Foundation
import SwiftUI
import SwiftData

struct Workout: Identifiable {
    var id = UUID()
    var workoutName: String
    var exercises: [Exercise]
    var workoutDate: Date
    var workoutNote: String
    
    init(id: UUID = UUID(), workoutName: String, exercises: [Exercise], workoutDate: Date, workoutNote: String) {
        self.id = id
        self.workoutName = workoutName
        self.exercises = exercises
        self.workoutDate = workoutDate
        self.workoutNote = workoutNote
    }
}

struct WorkoutView: View {
//    var egExercises = Exercises()
    
    var workout = Workout(workoutName: "Leg Day", exercises: [
        Exercise(exerciseName: "Leg Press", weight: 500, reps: 5, percentage: 80, restTime: 180),
        Exercise(exerciseName: "Squat", weight: 300, reps: 1, percentage: 100, restTime: 180),
        Exercise(exerciseName: "Calf Raise", weight: 0, reps: 10, percentage: 50, restTime: 180),
    ], workoutDate: Date(), workoutNote: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
    var body: some View {
        Text(workout.workoutName)
            .font(.headline)
        VStack{
            NavigationLink {
                Text("\(workout.workoutDate, format: Date.FormatStyle(date: .numeric, time: .standard))")
            } label: {
                Text(workout.workoutDate, format: Date.FormatStyle(date: .numeric, time: .standard))
            }
            @State var workoutNote = workout.workoutNote
            ExerciseView(exercises: workout.exercises)
            Text("Workout Notes:")
                .padding()
                .bold()
            ExpandViewer{
                TextField("WorkoutNotes", text: $workoutNote, axis: . vertical)
            }
            .padding()
        }
    }
}

#Preview{
    WorkoutView()
}
