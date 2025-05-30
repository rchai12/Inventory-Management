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
    apiKey: 'AIzaSyCyM5yLOAtb7IMLNwB42gSm1evos_SrfsQ',
    appId: '1:751667133408:web:3564c93d16d7473eb6c985',
    messagingSenderId: '751667133408',
    projectId: 'inventory-8a1ca',
    authDomain: 'inventory-8a1ca.firebaseapp.com',
    storageBucket: 'inventory-8a1ca.firebasestorage.app',
    measurementId: 'G-8GMJE5052S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAazfIw6gnesNc-v48FAkIneq7X2265WU4',
    appId: '1:751667133408:android:83d01bd354b37388b6c985',
    messagingSenderId: '751667133408',
    projectId: 'inventory-8a1ca',
    storageBucket: 'inventory-8a1ca.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAC6jNsexqTB0EPev1d_WbbXpJG7iJzwDA',
    appId: '1:751667133408:ios:c47607b4cb650e34b6c985',
    messagingSenderId: '751667133408',
    projectId: 'inventory-8a1ca',
    storageBucket: 'inventory-8a1ca.firebasestorage.app',
    iosBundleId: 'com.example.activity11',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAC6jNsexqTB0EPev1d_WbbXpJG7iJzwDA',
    appId: '1:751667133408:ios:c47607b4cb650e34b6c985',
    messagingSenderId: '751667133408',
    projectId: 'inventory-8a1ca',
    storageBucket: 'inventory-8a1ca.firebasestorage.app',
    iosBundleId: 'com.example.activity11',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCyM5yLOAtb7IMLNwB42gSm1evos_SrfsQ',
    appId: '1:751667133408:web:c4ad93b52b3a81ffb6c985',
    messagingSenderId: '751667133408',
    projectId: 'inventory-8a1ca',
    authDomain: 'inventory-8a1ca.firebaseapp.com',
    storageBucket: 'inventory-8a1ca.firebasestorage.app',
    measurementId: 'G-KX2P70GSFK',
  );
}
