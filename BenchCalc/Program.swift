//
//  Program.swift
//  BenchCalc
//
//  Created by zma on 3/7/25.
//

import SwiftUI

struct Program: Identifiable{
    var id = UUID()
    var programName:String
    var workouts: [Workout]
    var startDate: Date
    var endDate: Date
    var programNote: String
    
    init(id: UUID = UUID(), programName: String, workouts: [Workout], startDate: Date, endDate: Date, programNote: String) {
        self.id = id
        self.programName = programName
        self.workouts = workouts
        self.startDate = startDate
        self.endDate = endDate
        self.programNote = programNote
    }
}

struct ProgramView: View {
    var body: some View {
        WorkoutView()
    }
}

#Preview{
    ProgramView()
}
