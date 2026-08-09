import SwiftUI
import SwiftData

struct ContentView: View {
    init(
        goals: [Goal] = [
            Goal(id: "1", title: "Drink water!"),
            Goal(id: "2", title: "Walk")
        ],
        name: String = "Paige",
        onEditHabits: (() -> Void)? = nil
    ) {
        self._goals = State(initialValue: goals)
        self._name = State(initialValue: name)
        self.onEditHabits = onEditHabits
    }
    @Environment(\.modelContext) private var context
    @Query var records: [DailyRecord]
    
    @State var goals: [Goal] = {
        let saved = UserDefaults.standard.array(forKey: "userHabits") as? [String] ?? []
        return saved.enumerated().map { i, title in
            Goal(id: "habit\(i)", title: title)
        }
    }()
    @State var name: String
    @State private var selectedDate: Date = Calendar.current.startOfDay(for: Date())
    @State private var totalStarsOverride: Int = 0
    @State private var completedIDsOverride: [String] = []
    var onEditHabits: (() -> Void)? = nil

    
    // MARK: - Computed Properties
//
//    var totalStars: Int {
//        let day = Calendar.current.startOfDay(for: selectedDate)
//        return records.first(where: {
//            Calendar.current.isDate($0.date, inSameDayAs: day)
//        })?.stars ?? 0
//    }

    var localCalendar: Calendar {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone.current
        return cal
    }
    
    func toggleHabit(_ goal: Goal) {
        let day = Calendar.current.startOfDay(for: selectedDate)
        var ids = completedIDsOverride
        if ids.contains(goal.id) {
            ids.removeAll { $0 == goal.id }
        } else {
            ids.append(goal.id)
        }
        completedIDsOverride = ids
        totalStarsOverride = ids.count

        let descriptor = FetchDescriptor<DailyRecord>()
        let allRecords = (try? context.fetch(descriptor)) ?? []
        if let existing = allRecords.first(where: { Calendar.current.isDate($0.date, inSameDayAs: day) }) {
            existing.completedHabitIDs = ids
        } else {
            context.insert(DailyRecord(date: day, completedHabitIDs: ids))
        }
        try? context.save()
    }
    
    
    func isCompleted(_ goal: Goal) -> Bool {
        completedIDs().contains(goal.id)
    }
    
    func completedIDs() -> [String] {
        recordForSelectedDate()?.completedHabitIDs ?? []
    }
    
    func recordForSelectedDate() -> DailyRecord? {
        let day = Calendar.current.startOfDay(for: selectedDate)
        return records.first { Calendar.current.isDate($0.date, inSameDayAs: day) }
    }
        
//func saveStarsForSelectedDate(stars: Int) {
//        let day = Calendar.current.startOfDay(for: selectedDate)
//        if let existing = records.first(where: { Calendar.current.isDate($0.date, inSameDayAs: day) }) {
//            existing.stars = stars
//        } else {
//            let record = DailyRecord(date: day, stars: stars)
//            context.insert(record)
//        }
//        try? context.save()
//        
//        updateGoalsForSelectedDate(stars: stars)
//        print("Saved \(stars) stars for \(day)")
//    }

    func updateGoalsForSelectedDate() {
        let day = Calendar.current.startOfDay(for: selectedDate)
        let descriptor = FetchDescriptor<DailyRecord>()
        let allRecords = (try? context.fetch(descriptor)) ?? []
        let record = allRecords.first { Calendar.current.isDate($0.date, inSameDayAs: day) }
        let ids = record?.completedHabitIDs ?? []
        completedIDsOverride = ids
        totalStarsOverride = ids.count
    }

    func recordFor(date: Date) -> DailyRecord? {
        records.first { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }
    

//    func saveToday(stars: Int) {
//        let today = Calendar.current.startOfDay(for: Date())
//        if let existing = records.first(where: { Calendar.current.isDate($0.date, inSameDayAs: today) }) {
//            existing.stars = stars
//        } else {
//            let record = DailyRecord(date: today, stars: stars)
//            context.insert(record)
//        }
//    }
//    
    func weekDates(for date: Date) -> [Date] {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        // In the Gregorian calendar, Sunday = 1 ... Saturday = 7
        let startOfWeek = calendar.date(byAdding: .day, value: -(weekday - 1), to: calendar.startOfDay(for: date))!
        return (0..<7).map { calendar.date(byAdding: .day, value: $0, to: startOfWeek)! }
    }

    func currentStreak() -> Int {
        let calendar = Calendar.current
        // Sort records up to and including selectedDate, most recent first
        let sorted = records
            .filter { $0.date <= selectedDate }
            .sorted { $0.date > $1.date }
        var streak = 0
        for record in sorted {
           // if record.stars == goals.count { streak += 1 } else { break }
        }
        return streak
    }

    func bestStreak() -> Int {
        let calendar = Calendar.current
        // Only consider records up to selectedDate
        let sorted = records
            .filter { $0.date <= selectedDate }
            .sorted { $0.date < $1.date }
        var best = 0, current = 0
        for record in sorted {
           // if record.stars == goals.count { current += 1; best = max(best, current) }
          //  else { current = 0 }
        }
        return best
    }

//    func weeklyTotal() -> Int {
//      //  weekDates(for: selectedDate).reduce(0) { $0 + (recordFor(date: $1)?.stars ?? 0) }
//    }
    
    // MARK: - Helper for today's date string
    func todayString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: Date())
    }
    
    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                
                // Title
                HStack {
                    Text("\(name)'s Stars")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.black)
                    Spacer()
                    if let onEditHabits = onEditHabits {
                            Button(action: { onEditHabits()}) {
                                HStack {
                                    Image(systemName: "heart.fill")
                                    Text("Edit Habits")
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Theme.accent)
                                .foregroundColor(.white)
                                .cornerRadius(16)
                                .shadow(color: Theme.accent.opacity(0.2), radius: 4, x: 0, y: 2)
                            }
                    
                    }
                }
                .padding(.top)
                
                // Date Row
                HStack {
                    Button(action: {
                        selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate)!
                       
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                    }
                    .padding(.trailing, 8)
                    
                    Text(dateString(selectedDate))
                        .font(Theme.font(size: 22, weight: .bold))
                        .foregroundColor(Theme.secondaryText)
                        .frame(maxWidth: .infinity)
                    
                    Button(action: {
                        selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!
                    }) {
                        Image(systemName: "chevron.right")
                            .font(.title2)
                            .foregroundColor(Theme.text)
                    }
                    .padding(.leading, 8)
                    .disabled(Calendar.current.isDateInToday(selectedDate))
                }
                .padding(.top)
                
                // Goals
                VStack(spacing: 15) {
                    ForEach(goals.indices, id: \.self) { i in
                        HStack {
                            Text(goals[i].title)
                                .font(Theme.font(size: 18, weight: .semibold))
                                .foregroundColor(Theme.text)
                            Spacer()
                            Button {
                                toggleHabit(goals[i])
                            } label: {
                                StarView(filled: completedIDsOverride.contains(goals[i].id))
                                    .scaleEffect(completedIDsOverride.contains(goals[i].id) ? 1.2 : 1.0)
                                    .animation(.spring(), value: completedIDsOverride.count)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .padding()
                .background(Theme.card)
                .cornerRadius(20)
                .shadow(color: Theme.accent.opacity(0.15), radius: 8, x: 0, y: 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Theme.accent, lineWidth: 2)
                )
                
                // Total Stars
                VStack(spacing: 8) {
                    Text("Total Today")
                        .font(.headline)
                    HStack {
                        ForEach(0..<goals.count, id: \.self) { i in
                            StarView(filled: i < totalStarsOverride)
                        }
                    }
                    .font(.largeTitle)
                    Text("\(totalStarsOverride) / \(goals.count) Stars")
                        .foregroundStyle(.secondary)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(16)
                
                // Streaks
                VStack(spacing: 8) {
                    Text("👾 Current Streak: \(currentStreak()) days")
                        .font(.headline)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(16)
                
                // Weekly Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("🌸 This Week")
                        .font(Theme.font(size: 20, weight: .bold))
                        .foregroundColor(Theme.accent)
                    
                    ForEach(weekDates(for: selectedDate), id: \.self) { day in
                        if day <= Calendar.current.startOfDay(for: selectedDate) {
                            let stars = recordFor(date: day)?.completedHabitIDs.count ?? 0
                            WeekRow(date: day, stars: stars, maxStars: goals.count)
                        }
                    }
                    
                    Divider()
                    
                    let weeklyTotal = weekDates(for: selectedDate)
                        .filter { $0 <= Calendar.current.startOfDay(for: selectedDate) }
                        .reduce(0) { $0 + (recordFor(date: $1)?.completedHabitIDs.count ?? 0) }
                    let daysElapsed = weekDates(for: selectedDate)
                        .filter { $0 <= Calendar.current.startOfDay(for: selectedDate) }.count
                    Text("Total: \(weeklyTotal) / \(goals.count * daysElapsed) ⭐")
                        .font(.headline)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(16)
            }
            .padding(.horizontal)
            .padding(.bottom, 100)
        }
        .onAppear {
            updateGoalsForSelectedDate()
        }
        .onChange(of: selectedDate) { _, _ in
            updateGoalsForSelectedDate()
        }
        .background(Theme.background)
    }
    // Helper for date string
    func dateString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
#Preview {
    ContentView(
        goals: [
            Goal(id: "1", title: "Drink water"),
            Goal(id: "2", title: "Stretch")
        ],
        name: "Paige"
    )
}
