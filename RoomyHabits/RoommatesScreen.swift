import SwiftUI
import SwiftData

struct RoommatesScreen: View {
    let name: String
    let goals: [Goal]
    @Query var records: [DailyRecord]
    
    // Compute last 7 days
    func last7Days() -> [Date] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return (0..<7).map { calendar.date(byAdding: .day, value: -$0, to: today)! }.reversed()
    }
    
    // Find record for a given date
    func recordFor(date: Date) -> DailyRecord? {
        records.first { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }
    
    var body: some View {
        ScrollView {
            RoommatesWeekView(
                roommates: [
                    Roommate(
                        name: name,
                        completions: last7Days().map { _ in Bool.random() }
                    ),
                    Roommate(
                        name: "Andi",
                        completions: last7Days().map { _ in Bool.random() }
                    )
                ],
                days: last7Days()
            )
            .padding()
        }
        .navigationTitle("Roommates")
    }
}
