# RoomyHabits

A personal habit and mood-tracking app built with **SwiftUI** and **SwiftData**. RoomyHabits combines daily habit tracking with guided mood and symptom check-ins to help users recognize patterns in their routines and well-being over time.

##  Features

* **Daily habit tracking**

  * Track daily habits and completion progress
  * Persistent habit data across dates
  * Star-based habit tracking for a simple, encouraging experience

* **Daily check-ins**

  *

* **History**

  * Review previous daily entries
  * Browse mood, symptoms, and habit activity over time

* **Onboarding**

  * Guided setup flow for new users
  * Personalize the app with a name and initial habits

* **Native Swift experience**

  * Built entirely with SwiftUI
  * Local persistence using SwiftData
  * Designed around Apple's native navigation and UI patterns

##  Tech Stack

| Technology    | Purpose                 |
| ------------- | ----------------------- |
| **Swift**     | Application development |
| **SwiftUI**   | User interface          |
| **SwiftData** | Local data persistence  |
| **Xcode**     | Development environment |

## Architecture

The app uses a SwiftUI-oriented architecture with models, views, and state-driven navigation.

```text
RoomyHabits
├── Models
│   ├── Goal
│   └── DailyRecord
    └── Roommate
│
├── Views
│   ├── ContentView
│   ├── StarView
│   ├── RoommatesScreen
│   ├── Setupview
│   └── 
│
└── Persistence
    └── SwiftData
```

SwiftUI's declarative approach allows the UI to react automatically to changes in the underlying application state, while SwiftData provides persistent storage for user-created records.

##  App Flow

```text
First Launch
     │
     ▼
  Onboarding
     │
     ▼
  Daily Check-In
     │
     ├── Symptoms
     │
     ├── Mood Assessment
     │
     └── Habits
     │
     ▼
 Today's Entry
     │
     ▼
   History
```

## Data Persistence

User data is stored locally using **SwiftData**, allowing daily records and habits to persist between app launches.

The data model separates recurring habit information from individual daily records, allowing the app to maintain a history of previous check-ins while continuing to support changing habits over time.

##  Design

RoomyHabits is designed around a simple, approachable interface that makes daily tracking feel lightweight rather than clinical or overwhelming.

The UI uses:

* SwiftUI navigation
* Native controls and pickers
* Rounded cards and components
* Progress-oriented interactions
* Guided multi-step forms
* Responsive layouts for different screen sizes

## 🚀 Getting Started

### Requirements

* macOS
* Xcode
* iOS Simulator or an iOS device
* A recent version of Swift supporting SwiftData

### Installation

1. Clone the repository.

```bash
git clone <repository-url>
```

2. Open the project in Xcode.

3. Select an iOS Simulator or connected device.

4. Build and run the application.

## Future Improvements

Potential future improvements include:

* Mood and habit trend visualizations
* More detailed historical insights
* Customizable questionnaires
* Habit reminders and notifications
* iCloud synchronization
* Additional widgets
* Improved accessibility support

##  What I Learned

This project provided hands-on experience with:

* Building applications with **SwiftUI**
* Managing application state using SwiftUI's property wrappers
* Designing persistent data models with **SwiftData**
* Creating multi-step onboarding and form experiences
* Handling relationships between recurring data and daily records
* Building reusable SwiftUI components
* Designing a native iOS experience from the ground up

## 📄 License

This project is for personal and educational use.
