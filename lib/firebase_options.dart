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
    apiKey: 'AIzaSyBPNQ8sh1zKeq9CUjcI1oxiXINw2FVi3e0',
    appId: '1:1070069241989:web:ce56f0cec7c3271b4cf1ec',
    messagingSenderId: '1070069241989',
    projectId: 'kafil-e32f1',
    authDomain: 'kafil-e32f1.firebaseapp.com',
    databaseURL: 'https://kafil-e32f1-default-rtdb.firebaseio.com',
    storageBucket: 'kafil-e32f1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAwD0V7xBA-DRXXtr3E1UswsllmxBBV5vk',
    appId: '1:1070069241989:android:2221699653d3dac64cf1ec',
    messagingSenderId: '1070069241989',
    projectId: 'kafil-e32f1',
    databaseURL: 'https://kafil-e32f1-default-rtdb.firebaseio.com',
    storageBucket: 'kafil-e32f1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBvJRrQSO0aHCLHYmQuSQPEXQMK5uW-htM',
    appId: '1:1070069241989:ios:a91ec2ae1f8b57ca4cf1ec',
    messagingSenderId: '1070069241989',
    projectId: 'kafil-e32f1',
    databaseURL: 'https://kafil-e32f1-default-rtdb.firebaseio.com',
    storageBucket: 'kafil-e32f1.appspot.com',
    iosClientId: '1070069241989-gfl81fb3v1rujdam93f2dooltjhba2rj.apps.googleusercontent.com',
    iosBundleId: 'com.example.kafil',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBvJRrQSO0aHCLHYmQuSQPEXQMK5uW-htM',
    appId: '1:1070069241989:ios:cfa8de38dddabede4cf1ec',
    messagingSenderId: '1070069241989',
    projectId: 'kafil-e32f1',
    databaseURL: 'https://kafil-e32f1-default-rtdb.firebaseio.com',
    storageBucket: 'kafil-e32f1.appspot.com',
    iosClientId: '1070069241989-2tgnoerk3cl29f43u7gck72hoeqll7q1.apps.googleusercontent.com',
    iosBundleId: 'com.example.kafil.RunnerTests',
  );
}
