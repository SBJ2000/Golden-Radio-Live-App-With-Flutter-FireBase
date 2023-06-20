# Golden-Radio-Live-App-With-Flutter-FireBase
![Project Logo](https://github.com/SBJ2000/Golden-Radio-Live-App-With-Flutter-FireBase/blob/main/Images/Logo.jpg)

## Project Description
"Golden Radio Live App is a mobile application developed using Flutter and Firebase, aimed at providing a convenient and enjoyable radio streaming experience for the elderly. 
With its intuitive interface and seamless integration with Firebase backend, users can easily access and listen to their favorite Tunisian radio stations. 
Stay connected to the golden era of radio with this user-friendly and feature-rich app. 

### Project Architecture :
Before going into the application, we need to understand correctly the architecture that the developer adapted to build his project & what are the toold needed, which is in this case:
![Project Architecture](https://github.com/SBJ2000/Golden-Radio-Live-App-With-Flutter-FireBase/blob/main/Images/Architecture.png)
####Role of Flutter components:
1- Apis: This folder can contain the implementation of API services for interacting with Firebase services, such as authentication API or Firestore API.

2- Models: The models folder can include the data models representing the structure of your Firestore documents. These models will help you parse and manipulate data retrieved from Firestore.

3- Providers: In the providers folder, you can have classes or files implementing providers. These providers can handle the logic for managing user authentication states and data retrieval from Firestore.

4- Screens: The screens folder can contain the different screens or pages of your application. Each screen represents a separate UI component, and they can interact with the providers and APIs to display data and handle user actions.

5- Utils: The utils folder can include utility functions or helper classes used throughout the project. These can include functions for data manipulation, form validation, date formatting, or any other commonly used functionality.

6- Widget: The widget folder can contain reusable UI components or custom widgets that are used across multiple screens in your application. These widgets can help in building a consistent and modular UI design.

### Users & roles :
The application is designed for 1 type of users:
![User Roles](https://github.com/SBJ2000/Golden-Radio-Live-App-With-Flutter-FireBase/blob/main/Images/Roles.png)

## Installation & Usage

### Prerequisites:
![Flutter](https://img.shields.io/badge/Framework-Flutter-blue?logo=flutter)

    Flutter: Proficiency in Flutter framework for cross-platform mobile app development, including knowledge of widgets, states, navigation, and UI design principles.

![Firebase](https://img.shields.io/badge/Backend-Firebase-blue?logo=firebase)

    Firebase: Familiarity with Firebase services, such as Authentication, Firestore database, and Firebase Storage. Understanding of data manipulation, user management, and permissions.

![Dart](https://img.shields.io/badge/Language-Dart-blue?logo=dart)

    Dart: Proficiency in Dart programming language, including knowledge of data types, functions, classes, and asynchronous programming.

![IDE](https://img.shields.io/badge/IDE-Android%20Studio%20%7C%20Visual%20Studio%20Code-blue?logo=android-studio&logoColor=white)

    Integrated Development Environment (IDE): Experience with Android Studio or Visual Studio Code with Flutter plugin for development, including project setup, debugging, and code navigation.

![UI Design](https://img.shields.io/badge/UI%20Design-Principles-blue?logo=material-design)

    UI Design Skills: Understanding of user interface design principles, ability to create visually appealing interfaces, and familiarity with Flutter's widget hierarchy and layout system.

### Installation:
 
 1- Install Flutter:

Download the Flutter SDK from the official Flutter website: Flutter SDK.
Extract the downloaded SDK archive to a desired location on your computer.
Add the Flutter SDK's bin directory to your system's PATH variable.
 
 2- Install Dart:

Dart comes bundled with the Flutter SDK, so no separate installation is needed.
 
 3- Install an IDE:

Android Studio: Download and install Android Studio from the official website: Android Studio.
Visual Studio Code: Download and install Visual Studio Code from the official website: Visual Studio Code.

 4- Configure Flutter in your IDE:

For Android Studio: Install the Flutter and Dart plugins through the plugin marketplace. Then, set the Flutter SDK path in the IDE's settings.
For Visual Studio Code: Install the Flutter and Dart extensions from the Visual Studio Code marketplace.
 
 5- Set up Firebase:

Create a new project in the Firebase console: Firebase Console.
Enable the necessary Firebase services for your project, such as Authentication, Firestore, and Storage.
Obtain the Firebase configuration files (google-services.json for Android and GoogleService-Info.plist for iOS) and add them to your Flutter project's respective platform folders.

 6- Install project dependencies:

Open a terminal or command prompt and navigate to your Flutter project's root directory.
Run the command flutter pub get to download and install the required dependencies specified in the project's pubspec.yaml file.

 7- Connect a physical device or start an emulator:

Connect your physical device to your computer via USB or start an emulator using Android Studio's AVD Manager.

 8- Run the application:

Open a terminal or command prompt and navigate to your Flutter project's root directory.
Run the command flutter run to build and run your application on the connected device or emulator.

By following these steps, you should have the necessary tools and dependencies installed to start running this Flutter Firebase application.

### Usage
Let's have a look on the project with some screenshoots from the inside, & let's begin with the Sign Up Screen:
![Sign Up Page](https://github.com/SBJ2000/Golden-Radio-Live-App-With-Flutter-FireBase/blob/main/Images/SignUp.jpg)
