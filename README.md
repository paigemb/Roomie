# RoomyHabits 🌟

RoomyHabits is a lightweight iOS habit-tracking app built with **SwiftUI** and **SwiftData**. It turns daily habits into a simple star-based progress system, making it easy to check in each day and see progress throughout the week.

The app focuses on making habit tracking feel encouraging and approachable rather than overwhelming.

##  Features

### Personalized Setup

When opening the app for the first time, users are guided through a short setup flow where they can:

* Enter their name
* Create their own habits
* Add or remove habits
* Return to the setup flow later to edit their habits

User preferences are saved locally so they persist between app launches.

###  Daily Habit Tracking

The main screen displays the user's personalized habits and allows each habit to be completed with a single tap.

Completed habits are represented by filled stars, while incomplete habits remain outlined.

The app keeps track of which habits were completed for each individual day rather than only storing an overall completion count.

###  Date Navigation

Users can move between days to review and update their habit progress.

Each day's completed habits are stored independently, allowing users to look back at previous days without losing their current progress.

###  Daily Progress

The app provides a daily summary showing:

* Number of completed habits
* Total possible stars
* Current streak

This gives users an immediate view of how they are doing that day.

###  Weekly Progress

A weekly summary displays each day alongside its completed stars, providing a quick visual overview of progress throughout the week.

The app also calculates a cumulative weekly total based on the number of completed habits.

##  Built With

* **Swift**
* **SwiftUI**
* **SwiftData**
* **UserDefaults**
* **Xcode**

##  Project Structure

```text
RoomyHabits
├── RoomyHabitsApp
│
├── ContentView
│   └── Main habit-tracking interface
│
├── SetupView
│   └── User onboarding and habit configuration
│
├── DailyRecord
│   └── SwiftData model for daily habit completion
│
├── Goal
│   └── Lightweight model representing a user habit
│
├── StarView
│   └── Reusable star progress component
│
└── WeekRow
    └── Weekly progress display
```

##  Data Persistence

RoomyHabits uses **SwiftData** to persist daily habit completion.

Each `DailyRecord` stores a date along with the IDs of the habits completed that day. This allows the app to maintain a history of daily progress rather than only tracking the current day's state.

```swift
@Model
class DailyRecord {
    var date: Date
    var completedHabitIDs: [String]
}
```

User-specific preferences, including their name and habit list, are stored separately using `UserDefaults`.

This combination keeps the data model relatively lightweight while providing persistence across app launches.

##  Design

The interface is designed around a soft, playful visual style.

The onboarding experience uses:

* Rounded SwiftUI components
* Material backgrounds
* Gradient backgrounds
* Animated blurred shapes
* SF Symbols
* Spring animations
* Custom colors and typography

The main tracking screen uses cards, stars, and subtle animations to make daily interactions feel rewarding.

## App Flow

```text
First Launch
    │
    ▼
Enter Name
    │
    ▼
Learn How It Works
    │
    ▼
Create Habits
    │
    ▼
Daily Habit Tracking
    │
    ├── Complete Habits
    ├── Earn Stars
    ├── View Daily Progress
    └── View Weekly Progress
```

##  Technical Highlights

### SwiftUI State Management

The app uses SwiftUI's state-driven architecture to manage the selected date, habits, completion state, and onboarding flow.

Changing the selected date triggers the app to load the corresponding `DailyRecord`, allowing the UI to update automatically.

### SwiftData

SwiftData provides persistent storage for daily habit records.

The application creates a `ModelContainer` containing the `DailyRecord` model and injects it into the SwiftUI environment:

```swift
.modelContainer(sharedModelContainer)
```

### Local User Preferences

Habit names and the user's name are stored using `UserDefaults`, allowing the onboarding information to persist between launches.

### Reusable SwiftUI Components

Small pieces of the interface are separated into reusable components such as `StarView` and `WeekRow`. This keeps the main tracking view focused on application logic while allowing individual UI elements to be independently styled and reused.

##  Getting Started

### Requirements

* macOS
* Xcode
* iOS Simulator or a physical iOS device
* A version of Xcode supporting SwiftData

### Running the App

1. Clone the repository.

```bash
git clone <repository-url>
```

2. Open the project in Xcode.

3. Select an iOS Simulator or connected device.

4. Build and run the project.

5. Complete the onboarding flow and create your first habits.

##  Future Development

The current project provides the foundation for expanding RoomyHabits into a more comprehensive habit-tracking experience.

Potential future features include:

* Habit trends and visualizations
* Habit sharing
* A rewards system for earned stars
* Additional progress insights
* Notifications and reminders
* More detailed historical statistics

These features are not currently implemented and represent possible directions for future development.

## License

This project is currently intended as a personal project and portfolio piece.
