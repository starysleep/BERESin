# <summary><strong>Hi there :wave: , I'm Bintang and I'm Dyah! This our project for final assignment</strong></summary>
# BERESin APP

BERESin allows users to upload images, store their location, and view a history of their class duty. The app integrates with Firebase for authentication, Firestore for data storage, and Cloudinary for image hosting.

## Features

- User authentication with Firebase
- Image capture and upload to Cloudinary
- Location tracking using Geolocator
- Address retrieval using Geocoding
- History page to view past submissions
- Responsive UI with Flutter

## Technologies Used

- Flutter
- Dart
- Firebase (Firestore, Authentication, Storage)
- Cloudinary
- Geolocator
- Geocoding
- HTTP

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Firebase project setup
- Cloudinary account


Create a Firebase project at Firebase Console.
Add your Flutter app to the Firebase project.
Download the google-services.json file and place it in the android/app directory.
Configure Firestore and Authentication in the Firebase console.
Set up Cloudinary:

Create a Cloudinary account at Cloudinary.
Obtain your Cloudinary API credentials (API Key, API Secret, Cloud Name) and update them in the code.
Running the App
To run the app, use the following command:
flutter run

Usage
Authentication: Users can sign in using their email and password.
Image Upload: Users can take photos using the camera and upload them.
Location Tracking: The app checks if the user is within a specified radius and retrieves the address.
History: Users can view their submission history, including images, date, time, and address.
Code Structure
lib/: Contains the main application code.
Screens/: Contains different screens of the app (e.g., Beresin, HistoryScreen).
models/: Contains data models (e.g., post.dart).
resources/: Contains resource files (e.g., image storage methods).
utils.dart: Contains utility functions.
constants.dart: Contains constant values used throughout the app.
Contributing
Contributions are welcome! Please feel free to submit a pull request or open an issue.

License
This project is licensed under the MIT License. See the LICENSE file for details.

Acknowledgments
Flutter - The UI toolkit for building natively compiled applications.
Firebase - Backend services for mobile and web applications.
Cloudinary - Image and video management service.
Geolocator - Flutter plugin for accessing the device's location.
Geocoding - Flutter plugin for converting coordinates to addresses.

