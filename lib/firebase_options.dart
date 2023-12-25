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
    apiKey: 'AIzaSyAeczaBvXG5HXCvWo6btAxsRn5o-mQYRe8',
    appId: '1:1042373550213:web:8041d6cd415f5750e389ec',
    messagingSenderId: '1042373550213',
    projectId: 'fleet-focus-pro',
    authDomain: 'fleet-focus-pro.firebaseapp.com',
    storageBucket: 'fleet-focus-pro.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB4ea66U3ZIbCMqMp6ige0fUuccx_WhIt8',
    appId: '1:1042373550213:android:43a50d810f926697e389ec',
    messagingSenderId: '1042373550213',
    projectId: 'fleet-focus-pro',
    storageBucket: 'fleet-focus-pro.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBMxmXIVSPe-a0kctdXuKX5E7oFWX455HQ',
    appId: '1:1042373550213:ios:8faccde27101799fe389ec',
    messagingSenderId: '1042373550213',
    projectId: 'fleet-focus-pro',
    storageBucket: 'fleet-focus-pro.appspot.com',
    iosBundleId: 'com.fleetfocuspro.ffp.fleetFocusPro',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBMxmXIVSPe-a0kctdXuKX5E7oFWX455HQ',
    appId: '1:1042373550213:ios:ef495d320671c51fe389ec',
    messagingSenderId: '1042373550213',
    projectId: 'fleet-focus-pro',
    storageBucket: 'fleet-focus-pro.appspot.com',
    iosBundleId: 'com.fleetfocuspro.ffp.fleetFocusPro.RunnerTests',
  );
}
