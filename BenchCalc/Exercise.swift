//
//  Exercise.swift
//  BenchCalc
//
//  Created by zma on 3/4/25.
//

import Foundation

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
