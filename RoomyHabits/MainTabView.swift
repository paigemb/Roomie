import SwiftUI

struct MainTabView: View {
    @State var goals: [Goal]
    @State var name: String
    var onEditHabits: (() -> Void)? = nil

    var body: some View {
        TabView {
            ContentView(goals: goals, name: name, onEditHabits: onEditHabits)
                .tabItem {
                    Label("Home", systemImage: "star.fill")
                }
            NavigationView {
                RoommatesScreen(
                    name: name,
                    goals: goals
                )
            }
            .tabItem {
                Label("Roommates", systemImage: "person.2.fill")
            }
        }
    }
}
