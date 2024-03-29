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
    apiKey: 'AIzaSyBJXUmZ6g5qVgzIh65d9mf4LPcHzFcpIJg',
    appId: '1:190939375367:web:acbef3b98ec523ad3387a2',
    messagingSenderId: '190939375367',
    projectId: 'billeteramovilapp', 
    authDomain: 'billeteramovilapp.firebaseapp.com',
    storageBucket: 'billeteramovilapp.appspot.com',
    measurementId: 'G-WW90NRJ0LG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAo6c-WwrCnkEpuW3Zwazr8PZ_73nWB6o4',
    appId: '1:190939375367:android:9dd6659531ca0bbc3387a2',
    messagingSenderId: '190939375367',
    projectId: 'billeteramovilapp',
    storageBucket: 'billeteramovilapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdxpzf_GnhDjEdpss0K2WKH_5YPYTWFdo',
    appId: '1:190939375367:ios:96ab2e7bc54abd493387a2',
    messagingSenderId: '190939375367',
    projectId: 'billeteramovilapp',
    storageBucket: 'billeteramovilapp.appspot.com',
    iosClientId: '190939375367-i4qd63f2oehqdoeji0bthoa7g7se46p4.apps.googleusercontent.com',
    iosBundleId: 'com.example.billeteramovil',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCdxpzf_GnhDjEdpss0K2WKH_5YPYTWFdo',
    appId: '1:190939375367:ios:96ab2e7bc54abd493387a2',
    messagingSenderId: '190939375367',
    projectId: 'billeteramovilapp',
    storageBucket: 'billeteramovilapp.appspot.com',
    iosClientId: '190939375367-i4qd63f2oehqdoeji0bthoa7g7se46p4.apps.googleusercontent.com',
    iosBundleId: 'com.example.billeteramovil',
  );
}
