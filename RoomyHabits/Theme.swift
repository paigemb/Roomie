//
//  Theme.swift
//  RoomyHabits
//
//  Created by Paige B on 4/29/26.
//


import SwiftUI

struct Theme {
    // Cute & girly color palette
    static let background = Color(red: 1.0, green: 0.94, blue: 0.97) // soft pink
    static let card = Color(red: 1.0, green: 0.85, blue: 0.95) // lighter pink
    static let accent = Color(red: 0.98, green: 0.60, blue: 0.82) // hot pink
    static let star = Color(red: 1.0, green: 0.80, blue: 0.88) // pastel pink
    static let text = Color(red: 0.60, green: 0.20, blue: 0.40) // berry
    static let secondaryText = Color(red: 0.85, green: 0.40, blue: 0.60) // rose

    // Example font (system font with rounded design)
    static func font(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .rounded)
    }
    
    static func titleFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .custom("Didot", size: 30)
    }
}
