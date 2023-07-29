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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCnoWbeSJmK8FqGTzampcswCRlgavMgcW0',
    appId: '1:739352247687:web:6ee9157202f243a8662722',
    messagingSenderId: '739352247687',
    projectId: 'expense-tracker-ea8bd',
    authDomain: 'expense-tracker-ea8bd.firebaseapp.com',
    storageBucket: 'expense-tracker-ea8bd.appspot.com',
    measurementId: 'G-X1S3PM5NSB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDfmZPRLn9NtbqQDuw7Y7q5ozIJR8WWHfY',
    appId: '1:739352247687:android:f52f40b6df59c82a662722',
    messagingSenderId: '739352247687',
    projectId: 'expense-tracker-ea8bd',
    storageBucket: 'expense-tracker-ea8bd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDODTEFJv44sP2qZVcOiSmz89S93jwGHUA',
    appId: '1:739352247687:ios:afd5830a06979791662722',
    messagingSenderId: '739352247687',
    projectId: 'expense-tracker-ea8bd',
    storageBucket: 'expense-tracker-ea8bd.appspot.com',
    iosClientId:
        '739352247687-uuf8ffursdlorv6mmdf3rer8j2mtrgaa.apps.googleusercontent.com',
    iosBundleId: 'com.codesynth.expense',
  );
}
