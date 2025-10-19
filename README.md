# Dualify apprenticeship AFicorp assignment

Mobile Developer Assessment.
The app has been developed using Flutter **Flutter 3.29.2**

## Features

- State management with `flutter_bloc`
- Mocked data stored in `assets/mock_data.json`

## Prerequisites

- [FVM (Flutter Version Management)](https://fvm.app/docs/getting_started/installation)
- Flutter (managed via FVM)

## Setup Instructions

### 1. Install FVM

Follow the [official FVM installation guide](https://fvm.app/docs/getting_started/installation) for your platform.

### 2. Install the required Flutter version

This project uses **Flutter 3.29.2**. FVM will automatically use the version specified in `.fvmrc`.

```sh
fvm install
```

### 3. Run the app using FVM

Use FVM to ensure the correct Flutter version is used.
Before running, please select the device in VSCode

```sh
fvm flutter pub get
fvm flutter run
```
Or you can open main.dart file and press the run button in VS Code.

## Mock Data

- The app uses mocked data located at: `assets/mock_data.json`.
- To change the data, edit the `assets/mock_data.json` file.
- After editing, hot reload or restart the app to see changes.

## App Feature

- The app contains: 
  - Dashboard feature that displays the mock data
  - Onboard screen: to onboard an apprentice
  - Login screen: To log in the user
- The progress bar & the completion days are automatically processed based on the user-selected start date and the duration.
- The days (eg: mon, tue) are grayed out if the start date is greater
- User can log out and log in using their name & given password to view the resumed data.
- If you want to onboard a new user, please delete the app and reinstall or rerun (from VSCode) to delete the stored data from local storage.

#### Thank you for the opportunity to complete this assignment as part of the interview process. I appreciate your time and consideration. Your feedback would be greatly appreciated ☺️


