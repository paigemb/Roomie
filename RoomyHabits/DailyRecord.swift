//
//  DailyRecord.swift
//  RoomyHabits
//
//  Created by Paige B on 3/10/26.
//


import SwiftData
import Foundation

@Model
class DailyRecord {
    var date: Date
    var completedHabitIDs: [String] 
    
    init(date: Date, completedHabitIDs: [String] = []) {
        self.date = date
        self.completedHabitIDs = completedHabitIDs
    }
}
