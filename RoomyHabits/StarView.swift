//
//  StarView.swift
//  RoomyHabits
//
//  Created by Paige B on 3/10/26.
//


import SwiftUI

struct StarView: View {
    var filled: Bool
    
    var body: some View {
        Image(systemName: filled ? "star.fill" : "star")
            .foregroundColor(Theme.text)
            .font(.title2)
    }
}
