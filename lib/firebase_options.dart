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
    apiKey: 'AIzaSyBsD9BHrqFdncQV8JkJ228kwcnHST5M92U',
    appId: '1:1051621258915:web:8cb96bdcc2293b1f6bb116',
    messagingSenderId: '1051621258915',
    projectId: 'authentication-876a9',
    authDomain: 'authentication-876a9.firebaseapp.com',
    databaseURL: 'https://authentication-876a9-default-rtdb.firebaseio.com',
    storageBucket: 'authentication-876a9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAkHDmTxX3bm7MI8xa6HQ-9ILIR1NZZ8FE',
    appId: '1:1051621258915:android:a053cfb2fd0e2fb76bb116',
    messagingSenderId: '1051621258915',
    projectId: 'authentication-876a9',
    databaseURL: 'https://authentication-876a9-default-rtdb.firebaseio.com',
    storageBucket: 'authentication-876a9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAbRF7mUc931jwb6NGYt4YPB0b5C3nLA6w',
    appId: '1:1051621258915:ios:02d2363987e081396bb116',
    messagingSenderId: '1051621258915',
    projectId: 'authentication-876a9',
    databaseURL: 'https://authentication-876a9-default-rtdb.firebaseio.com',
    storageBucket: 'authentication-876a9.appspot.com',
    iosClientId: '1051621258915-b8ujfnrif57ujauq7mbpb9kcvlff33db.apps.googleusercontent.com',
    iosBundleId: 'com.example.modernlogintute',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAbRF7mUc931jwb6NGYt4YPB0b5C3nLA6w',
    appId: '1:1051621258915:ios:02d2363987e081396bb116',
    messagingSenderId: '1051621258915',
    projectId: 'authentication-876a9',
    databaseURL: 'https://authentication-876a9-default-rtdb.firebaseio.com',
    storageBucket: 'authentication-876a9.appspot.com',
    iosClientId: '1051621258915-b8ujfnrif57ujauq7mbpb9kcvlff33db.apps.googleusercontent.com',
    iosBundleId: 'com.example.modernlogintute',
  );
}

