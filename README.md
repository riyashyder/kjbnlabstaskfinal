# KJBN Labs Task

Welcome to the KJBN Labs Task Flutter project! This application is designed to showcase a simple interactive experience, including a splash screen and a main screen with random number generation and timer functionality.

## Developer

This project was developed by Sheik Riyas H.

- **Developer:** [SHEIK RIYAS H]
- **Email:** sheikriyas92@gmail.com
- **GitHub:** https://github.com/riyashyder

Output:

https://github.com/riyashyder/kjbnlabstaskfinal/assets/99108924/b442c86e-630e-4aa9-a7ae-09349434667f



## Getting Started

To get started with Flutter development, follow these steps:

1. **Install Flutter:**
    - [Install Flutter](https://flutter.dev/docs/get-started/install) on your machine.

2. **Set Up an IDE:**
    - Choose your preferred IDE (e.g., Visual Studio Code, IntelliJ) and install the Flutter and Dart plugins.

3. **Clone the Repository:**
   ```bash
   git clone https://github.com/riyashyder/kjbnlabstaskfinal.git


Navigate to the project directory: cd kjbnlabs_task

In pubspec.yaml file you need to add dependencies:

provider: ^6.1.1
flutter_timer_countdown: ^1.0.7
shared_preferences: ^2.2.2


Install Dependencies : flutter pub get

To Run the Application : flutter run

Project Structure:

The project is organized into several files to maintain a clean and modular codebase:

main.dart: Entry point of the application, includes initialization and runApp method.
splash_screen.dart: Defines the splash screen widget and navigation logic.
app_state.dart: Manages the state of the application using ChangeNotifier.
my_app.dart: Defines the main application widget and sets up the theme.
my_home_page.dart: Implements the main screen widget, including the UI elements and user interactions.


This program appears to be a simple Flutter application with a game-like functionality. Let's break down its main features:

1. **Splash Screen:**
    - A splash screen is displayed at the beginning of the app for 3 seconds, showing an image (presumably the KJBN Labs logo).

2. **Main Screen:**
    - After the splash screen, the app navigates to the main screen (`MyHomePage`), which consists of a gradient background and a central widget tree.

3. **Game Logic (`AppState` Class):**
    - The `AppState` class, which extends `ChangeNotifier`, manages the state of the game.
    - It includes variables like `widget1Value`, `widget2Value`, `successScore`, `failureScore`, `totalAttempts`, `timerValue`, `showSuccessMessage`, and `showFailureMessage`.
    - The game logic involves tapping a button (`ElevatedButton`) triggering the `onTapWidget5` function. This function generates a random number (`widget2Value`), compares it to the current second (`widget1Value`), and updates scores and messages accordingly.
    - A timer (`_timer`) is used to implement a countdown from 5 seconds (`timerValue`), updating the UI and triggering a penalty if the timer reaches zero.

4. **UI Elements (`MyWidgetTree` Class):**
    - The UI includes two containers displaying "Current Second" and "Random Number" with corresponding values.
    - A container displays success or failure messages based on game outcomes, with dynamic background colors.
    - A circular progress indicator represents the countdown timer.
    - An elevated button allows the user to interact with the game by tapping.

5. **Message Display (`_getMessage` Function):**
    - A function is defined to determine the message displayed in the UI based on success, failure, or timeout conditions.

In summary, this program seems to implement a simple game where the user needs to tap a button within a time limit to match a randomly generated number with the current second. The game keeps track of scores, attempts, and displays success or failure messages. It provides a basic interactive experience showcasing Flutter's UI capabilities and state management using the `provider` package.









