// File: lib/firebase_options.dart

// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for your project
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
      default:
        throw UnsupportedError(
          'FirebaseOptions are not configured for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyA7G97O7i0pcZfQIzh8W-NBWUpFvcWIHvM",
    authDomain: "cssd-bb748.firebaseapp.com",
    databaseURL:
        "https://cssd-bb748-default-rtdb.asia-southeast1.firebasedatabase.app",
    projectId: "cssd-bb748",
    storageBucket: "cssd-bb748.firebasestorage.app",
    messagingSenderId: "698390090309",
    appId: "1:698390090309:web:1db01a33fed62a1d45492c",
    measurementId: "G-JEC0GBF714",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyBNo4kxU1qPf2vvqemy-2PgVtkPCrUmOtM",
    appId: "1:698390090309:android:6b8d9a68eff6047045492c",
    messagingSenderId: "698390090309",
    projectId: "com.cssd.cssd_project",
    storageBucket: "cssd-bb748.firebasestorage.app",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyAOep9dcxCFuqderdVShYIEuFkv-DH8XfA",
    appId: "1:698390090309:ios:bb73b8de7931d79845492c",
    messagingSenderId: "698390090309",
    projectId: "cssd-bb748",
    storageBucket: "cssd-bb748.firebasestorage.app",
    iosBundleId: "com.cssd.cssdProject",
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "AIzaSyC6i5iw-nWvPhbuZB6yyjCi6HsvhYTY_0",
    appId: "1:975132094699:ios:xxxxxxxxxxxxxxxxxxxxxx",
    messagingSenderId: "975132094699",
    projectId: "cssd-bb748",
    storageBucket: "cssd-bb748.firebasestorage.app",
    iosBundleId: "com.cssd.cssdProject",
  );
}
