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
    apiKey: 'AIzaSyDWRxosgEonwSR4ftUWftrDcrAfY_1kxFQ',
    appId: '1:578806950110:web:458c49f841336d0e4f7a4f',
    messagingSenderId: '578806950110',
    projectId: 'quotes-4307f',
    authDomain: 'quotes-4307f.firebaseapp.com',
    storageBucket: 'quotes-4307f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyACZYAwDA5BhkuiFIV5bejwaV5RmBo18VA',
    appId: '1:578806950110:android:b877b69c2b2f3b304f7a4f',
    messagingSenderId: '578806950110',
    projectId: 'quotes-4307f',
    storageBucket: 'quotes-4307f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAQoMoMD3qr-i2m22ipscUqpKC5c_pUct4',
    appId: '1:578806950110:ios:0a569b57f6dd07e74f7a4f',
    messagingSenderId: '578806950110',
    projectId: 'quotes-4307f',
    storageBucket: 'quotes-4307f.appspot.com',
    iosClientId: '578806950110-qctgbgv7eou188peno3ht83ihv42r9to.apps.googleusercontent.com',
    iosBundleId: 'com.example.practical4',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAQoMoMD3qr-i2m22ipscUqpKC5c_pUct4',
    appId: '1:578806950110:ios:0a569b57f6dd07e74f7a4f',
    messagingSenderId: '578806950110',
    projectId: 'quotes-4307f',
    storageBucket: 'quotes-4307f.appspot.com',
    iosClientId: '578806950110-qctgbgv7eou188peno3ht83ihv42r9to.apps.googleusercontent.com',
    iosBundleId: 'com.example.practical4',
  );
}
