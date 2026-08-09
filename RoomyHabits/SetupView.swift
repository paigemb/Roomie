import SwiftUI

struct HabitItem: Identifiable, Equatable {
    let id = UUID()
    var text: String
}

struct SetupView: View {
    init(
        initialStep: Int = 0,
        onComplete: @escaping ([Goal], String) -> Void
    ) {
        self.onComplete = onComplete

        let savedHabits = UserDefaults.standard.array(forKey: "userHabits") as? [String] ?? []

        _habits = State(initialValue: savedHabits.isEmpty
                        ? [HabitItem(text: "")]
                        : savedHabits.map { HabitItem(text: $0) })

        _name = State(initialValue: UserDefaults.standard.string(forKey: "name") ?? "")

        _step = State(initialValue: initialStep)   // 👈 THIS is the key
    }
    private var nameStep: some View {
        VStack(alignment: .center, spacing: 28) {

            Spacer(minLength: 0)

            VStack(alignment: .center, spacing: 8) {
                Text("Hi there")
                    .font(.system(size: 38, weight: .bold, design: .rounded))

                Text("What should I call you?")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundStyle(.secondary)
            }

            TextField("Your name", text: $name)
                .padding(18)
                .background(
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .fill(.white.opacity(0.7))
                        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 6)
                )
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .scaleEffect(isTyping ? 1.02 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isTyping)

            Button {
                withAnimation {
                    step = 1
                }
            } label: {
                Text("Continue ✨")
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .background(Theme.accent)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
            }
            .padding(.top, 8)

            Spacer(minLength: 0)
        }
        
    }
    private var habitsStep: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text("Pick a few tiny habits 👾")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
            Text("You can change these later")
                .font(.system(size: 15, weight: .regular, design: .rounded))
            ForEach($habits) { $habit in
                HStack(spacing: 10) {

                    Image(systemName: "sparkles")
                        .foregroundStyle(Theme.accent.opacity(0.7))

                    TextField("Habit", text: $habit.text)
                        .padding()
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .focused($isTyping)

                    if habits.count > 1 {
                        Button {
                            withAnimation {
                                habits.removeAll { $0.id == habit.id }
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.red.opacity(0.7))
                        }
                    }
                }
            }
            HStack {
                Spacer()

                Button {
                    withAnimation {
                        habits.append(HabitItem(text: ""))
                    }
                } label: {
                    Label("Add Habit", systemImage: "plus")
                        .foregroundStyle(Theme.accent)
                }
            }
            if habits.allSatisfy({ $0.text.isEmpty }) {
                Text("Add at least one tiny habit")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Button {
                let trimmed = habits.map { $0.text.trimmingCharacters(in: .whitespacesAndNewlines) }
                let nonEmpty = trimmed.filter { !$0.isEmpty }

                let goals = nonEmpty.enumerated().map { i, title in
                    Goal(id: "habit\(i)", title: title)
                }

                UserDefaults.standard.set(nonEmpty, forKey: "userHabits")
                UserDefaults.standard.set(name, forKey: "name")

                onComplete(goals, name)

            } label: {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Theme.accent)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
    }
    private var instructionsStep: some View {
        VStack(alignment: .center, spacing: 18) {

            Text("How it works ✨")
                .font(.system(size: 26, weight: .bold, design: .rounded))

            VStack(alignment: .leading, spacing: 30) {

                Label("Add habits you want to build", systemImage: "sparkles")
                Label("Check them off daily to earn stars", systemImage: "star.fill")
                Label("Share your habit status with your favorite roommate", systemImage: "person.2.fill")
                Label("Keep track of trends", systemImage: "chart.line.uptrend.xyaxis")
                Label("Exchange stars for rewards", systemImage: "gift.fill")

            }
            .font(.system(size: 20, weight: .medium, design: .rounded))
            .foregroundStyle(.secondary)
            .padding()
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

            Button {
                withAnimation {
                    step = 1
                }

            } label: {
                Text("Start earning stars ✨")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Theme.accent)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
            }
        }
    }
    @State private var habits: [HabitItem]
    @State private var name: String
    @FocusState private var isTyping: Bool
    @State private var isPressed = false
    @State private var floaty = false
    @State private var step: Int = 0
    
    var onComplete: ([Goal], String) -> Void
    
    // MARK: - Init (fixes state initialization properly)
    init(onComplete: @escaping ([Goal], String) -> Void) {
        let savedHabits = UserDefaults.standard.array(forKey: "userHabits") as? [String] ?? []
        
        _habits = State(initialValue: savedHabits.isEmpty
                        ? [HabitItem(text: "")]
                        : savedHabits.map { HabitItem(text: $0) })
        
        _name = State(initialValue: UserDefaults.standard.string(forKey: "name") ?? "")
        self.onComplete = onComplete
    }

    var body: some View {
        ZStack {
            
            LinearGradient(
                colors: [
                    Theme.background,
                    Theme.background.opacity(0.7)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            ZStack {
                Color.clear
                
                Circle()
                    .fill(Theme.accent.opacity(0.8))
                    .frame(width: 240)
                    .blur(radius: 120)
                    .offset(
                        x: floaty ? -140 : 100,
                        y: floaty ? 220 : -200
                    )
                    .animation(.easeInOut(duration: 19).repeatForever(autoreverses: true), value: floaty)
                
                Circle()
                    .fill(Theme.star.opacity(0.6))
                    .frame(width: 200)
                    .blur(radius: 100)
                    .offset(x: 140, y: 250)
            }
            .animation(.easeInOut(duration: 60).repeatForever(autoreverses: true), value: UUID())
            
            VStack(spacing: 0) {
//                VStack(spacing: 6) {
//                    Text("Welcome 🩷")
//                        .font(.system(size: 28, weight: .bold, design: .rounded))
//
//                    Text("Let’s earn stars")
//                        .font(.system(size: 14, weight: .medium, design: .rounded))
//                        .foregroundStyle(.secondary)
//                }
//                .padding(.bottom, 10)
                VStack(spacing: 20) {

                    ZStack {

                        if step == 0 {
                            Color.clear
                                   .overlay(
                                       Circle()
                                           .fill(Theme.accent.opacity(0.15))
                                           .frame(width: 300)
                                           .blur(radius: 80)
                                           .offset(y: -200)
                                   )
                            nameStep
                                .transition(.opacity.combined(with: .move(edge: .trailing)))
                        }

                        if step == 2 {
                            habitsStep
                                .transition(.opacity.combined(with: .move(edge: .trailing)))
                                .padding(20)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                                .shadow(color: .black.opacity(0.08), radius: 18)
                        }
                        if step == 1 {
                                instructionsStep
                                    .transition(.opacity.combined(with: .move(edge: .trailing)))
                            }
                    }
                    .animation(.easeInOut(duration: 0.35), value: step)
                }
               
                .padding(.horizontal, 20)
            }
            .padding(.top, 30)
        }
        .onAppear {
            floaty.toggle()
        }
    }
}
#Preview {
    SetupView(initialStep: 2) { goals, name in
        print(goals, name)
    }
}
