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
    apiKey: 'AIzaSyAOAkkdD3ZU_5gSvg2qMun82lQKUE0e1dw',
    appId: '1:521317326662:web:d41b38dc71ef1571ea4f47',
    messagingSenderId: '521317326662',
    projectId: 'express-all',
    authDomain: 'express-all.firebaseapp.com',
    databaseURL: 'https://express-all-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'express-all.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDGRvbIQl1vgNT1lp_y2Or4ae9bLrIgB64',
    appId: '1:521317326662:android:e317c91bba08d3d5ea4f47',
    messagingSenderId: '521317326662',
    projectId: 'express-all',
    databaseURL: 'https://express-all-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'express-all.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC8R3bnPRhN5VZuI7MHYnKRUf4WgZ_tmKs',
    appId: '1:521317326662:ios:b22e5a0297a515b2ea4f47',
    messagingSenderId: '521317326662',
    projectId: 'express-all',
    databaseURL: 'https://express-all-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'express-all.appspot.com',
    iosBundleId: 'com.example.expressAll',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC8R3bnPRhN5VZuI7MHYnKRUf4WgZ_tmKs',
    appId: '1:521317326662:ios:b22e5a0297a515b2ea4f47',
    messagingSenderId: '521317326662',
    projectId: 'express-all',
    databaseURL: 'https://express-all-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'express-all.appspot.com',
    iosBundleId: 'com.example.expressAll',
  );
}
