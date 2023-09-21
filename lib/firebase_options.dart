// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBY-4hf3zYt9y7cfrQt5-pZ15N8nV64klE',
    appId: '1:321017225867:web:b4ebb56a60758ae54daa8e',
    messagingSenderId: '321017225867',
    projectId: 'finowise-2e9f5',
    authDomain: 'finowise-2e9f5.firebaseapp.com',
    storageBucket: 'finowise-2e9f5.appspot.com',
    measurementId: 'G-TSYEHT1ETH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCA6XSmBTBg0HU9KPnQbZCM6UscnKWNR1Q',
    appId: '1:321017225867:android:878ecdac60fc5a784daa8e',
    messagingSenderId: '321017225867',
    projectId: 'finowise-2e9f5',
    storageBucket: 'finowise-2e9f5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBUL2-3B1LEcA7wfGBZeu1WumA9vUQTUG0',
    appId: '1:321017225867:ios:d7ed9fb8f02edbcf4daa8e',
    messagingSenderId: '321017225867',
    projectId: 'finowise-2e9f5',
    storageBucket: 'finowise-2e9f5.appspot.com',
    iosBundleId: 'com.example.finoWise',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBUL2-3B1LEcA7wfGBZeu1WumA9vUQTUG0',
    appId: '1:321017225867:ios:f9e21549c6e429f24daa8e',
    messagingSenderId: '321017225867',
    projectId: 'finowise-2e9f5',
    storageBucket: 'finowise-2e9f5.appspot.com',
    iosBundleId: 'com.example.finoWise.RunnerTests',
  );
}