//
//  Goal.swift
//  RoomyHabits
//
//  Created by Paige B on 3/10/26.
//


import Foundation

import SwiftData

struct Goal: Identifiable, Hashable {
    var id: String
    var title: String
    var completed: Bool = false
}
