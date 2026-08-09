import SwiftUI

struct WeekRow: View {
    var date: Date
    var stars: Int
    var maxStars: Int = 3 // Default, but you can pass in the real value

    var body: some View {
            HStack {
                Text(date, format: .dateTime.weekday(.abbreviated))
                    .frame(width: 40)
                Spacer()
                HStack {
                    ForEach(0..<maxStars, id: \.self) { i in
                        Image(systemName: i < stars ? "star.fill" : "star")
                            .foregroundColor(Theme.text)
                    }
                }
            }
            .padding(.vertical, 4)
    }
}
