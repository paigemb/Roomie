import SwiftUI
import SwiftData

@main
struct RoomyHabitsApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            DailyRecord.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    @State private var showSetup: Bool = {
        let habits = UserDefaults.standard.array(forKey: "userHabits") as? [String]
        return habits?.isEmpty ?? true
    }()
    @State private var goals: [Goal] = []
    @State private var name: String = UserDefaults.standard.string(forKey: "name") ?? "Roomie"

    var body: some Scene {
        WindowGroup {
            if showSetup {
                SetupView { newGoals, newName in
                    self.goals = newGoals
                    self.name = newName
                    self.showSetup = false
                }
            } else {
                MainTabView(
                    goals: goals.isEmpty
                        ? (UserDefaults.standard.array(forKey: "userHabits") as? [String] ?? []).enumerated().map { i, title in Goal(id: "habit\(i)", title: title) }
                        : goals,
                    name: name,
                    onEditHabits: {
                        self.showSetup = true
                    }
                )
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
