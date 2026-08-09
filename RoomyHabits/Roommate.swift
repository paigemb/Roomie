//
//  Roommate.swift
//  RoomyHabits
//
//  Created by Paige B on 4/29/26.
//


import SwiftUI

struct Roommate {
    let name: String
    let completions: [Bool] // true if all habits completed for that day
}

struct RoommatesWeekView: View {
    let roommates: [Roommate]
    let days: [Date]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Roommates This Week")
                .font(.headline)
            HStack {
                Text("Name")
                    .frame(width: 100, alignment: .leading)
                ForEach(days, id: \.self) { day in
                    Text(shortDate(day))
                        .frame(width: 32)
                        .font(.caption)
                }
            }
            ForEach(roommates, id: \.name) { roommate in
                HStack {
                    Text(roommate.name)
                        .frame(width: 100, alignment: .leading)
                    ForEach(roommate.completions.indices, id: \.self) { i in
                        if roommate.completions[i] {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .frame(width: 32)
                        } else {
                            Image(systemName: "star")
                                .foregroundColor(.gray)
                                .frame(width: 32)
                        }
                    }
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
    }

    func shortDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }
}