# advanced-notes-app
# Advanced Notes App

A feature-rich note-taking Flutter application built with Slivers, reactive_forms, Hive, Provider, and GetIt.

## Features
- Dynamic `SliverAppBar` with collapsible behavior and action buttons.
- Note creation and editing with real-time form validation using `reactive_forms`.
- Local persistence using Hive for notes.
- Advanced search with debouncing using `rxdart`.
- Data conflict handling with version control.

## Setup
1. Clone the repository: `git clone https://github.com/yourgithubusername-advanced-notes-app`
2. Install dependencies: `flutter pub get`
3. Generate route and model files: `flutter pub run build_runner build --delete-conflicting-outputs`
4. Run the app: `flutter run`

## Prerequisites
- Flutter version: [Run `flutter --version` to check]
- Dart version: [Run `dart --version` to check]

## Design Choices
- Used `CustomScrollView` with `SliverList` and `SliverAppBar` to meet scrolling requirements.
- Implemented debounced search with `rxdart` to optimize performance.
- Handled data conflicts using a version field in the `Note` model.
- Structured state management with `Provider` for reactive UI updates.

## Challenges
- Ensuring Sliver layouts rendered correctly required extensive use of Flutter Inspector.
- Managing asynchronous Hive operations necessitated careful loading state handling.