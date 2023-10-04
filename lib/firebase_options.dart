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
    apiKey: 'AIzaSyAOB9xr7V6T4VY78ZI9gljSsEZWLYD3pp8',
    appId: '1:958147611840:web:449c0fe1b7f3614c00b125',
    messagingSenderId: '958147611840',
    projectId: 'followdp1',
    authDomain: 'followdp1.firebaseapp.com',
    storageBucket: 'followdp1.appspot.com',
    measurementId: 'G-BZMQELP3WD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCSA-VHJkl3jqXe_jL8ucG9rmzoJXh2HZE',
    appId: '1:958147611840:android:ddddbf6b2c704f0800b125',
    messagingSenderId: '958147611840',
    projectId: 'followdp1',
    storageBucket: 'followdp1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDYGqSi2L9MAy17u4VpVeQB_KmWm8_V49k',
    appId: '1:958147611840:ios:7d24d474ebf5429300b125',
    messagingSenderId: '958147611840',
    projectId: 'followdp1',
    storageBucket: 'followdp1.appspot.com',
    androidClientId: '958147611840-t89kjeb6kedr3dn2gf1nakrjtl91o6c2.apps.googleusercontent.com',
    iosClientId: '958147611840-hosjerop9v0g9cd69ubv81d52c05io4c.apps.googleusercontent.com',
    iosBundleId: 'com.example.followDp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDYGqSi2L9MAy17u4VpVeQB_KmWm8_V49k',
    appId: '1:958147611840:ios:16a54298b68803ea00b125',
    messagingSenderId: '958147611840',
    projectId: 'followdp1',
    storageBucket: 'followdp1.appspot.com',
    androidClientId: '958147611840-t89kjeb6kedr3dn2gf1nakrjtl91o6c2.apps.googleusercontent.com',
    iosClientId: '958147611840-vnmph9492jobcj747s2u008t6mb7rdnc.apps.googleusercontent.com',
    iosBundleId: 'com.example.followDp.RunnerTests',
  );
}
