// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyAyKv65KUH8OcR5D3s-RwByKPMiMaH6_xQ',
    appId: '1:665596723196:web:2a0a39d082390edc68bc79',
    messagingSenderId: '665596723196',
    projectId: 'aplikasir-database',
    authDomain: 'aplikasir-database.firebaseapp.com',
    storageBucket: 'aplikasir-database.appspot.com',
    measurementId: 'G-SQ6TZC5CJD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBWkPq7ed8GK1Lq0KY-unDhZPwUJM96Dag',
    appId: '1:665596723196:android:32c444c1956d2a3468bc79',
    messagingSenderId: '665596723196',
    projectId: 'aplikasir-database',
    storageBucket: 'aplikasir-database.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCo9DvY5pE9vxkGOZp85wFt3dV1D4lteQ8',
    appId: '1:665596723196:ios:d34f376349210fbc68bc79',
    messagingSenderId: '665596723196',
    projectId: 'aplikasir-database',
    storageBucket: 'aplikasir-database.appspot.com',
    iosBundleId: 'com.example.aplikasir',
  );
}
