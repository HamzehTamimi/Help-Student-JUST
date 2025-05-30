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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBbA7X8tp1F59HHWJ1FMkxHxIprFFU7Ios',
    appId: '1:747266049180:web:f1c5a938f3837ec7729959',
    messagingSenderId: '747266049180',
    projectId: 'help-student-402ab',
    authDomain: 'help-student-402ab.firebaseapp.com',
    storageBucket: 'help-student-402ab.firebasestorage.app',
    measurementId: 'G-JLH347K3L4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAvGmiKek_tyI-_ToIuo_ShCTHNRgczkM8',
    appId: '1:747266049180:android:2228e31a536585df729959',
    messagingSenderId: '747266049180',
    projectId: 'help-student-402ab',
    storageBucket: 'help-student-402ab.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCC8_SKkL2Es5OdRwklKZ-ZYNXLgbXVXCw',
    appId: '1:747266049180:ios:16c62cefc921013c729959',
    messagingSenderId: '747266049180',
    projectId: 'help-student-402ab',
    storageBucket: 'help-student-402ab.firebasestorage.app',
    iosBundleId: 'com.just.helpstudent',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCC8_SKkL2Es5OdRwklKZ-ZYNXLgbXVXCw',
    appId: '1:747266049180:ios:16c62cefc921013c729959',
    messagingSenderId: '747266049180',
    projectId: 'help-student-402ab',
    storageBucket: 'help-student-402ab.firebasestorage.app',
    iosBundleId: 'com.just.helpstudent',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBbA7X8tp1F59HHWJ1FMkxHxIprFFU7Ios',
    appId: '1:747266049180:web:e4b3a206286b322a729959',
    messagingSenderId: '747266049180',
    projectId: 'help-student-402ab',
    authDomain: 'help-student-402ab.firebaseapp.com',
    storageBucket: 'help-student-402ab.firebasestorage.app',
    measurementId: 'G-N9QRT28DFE',
  );
}
