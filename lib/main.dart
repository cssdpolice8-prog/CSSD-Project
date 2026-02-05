import 'package:cssd_project/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:cssd_project/homepage/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as dev;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // ห้าม init win_ble / bluetooth / dart:io
  }
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    dev.log(
      "🔥 FlutterError: ${details.exceptionAsString()}",
      stackTrace: details.stack,
    );
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    dev.log("🔥 Uncaught Error: $error", stackTrace: stack);
    return true;
  };
  FlutterError.onError = (details) {
    FlutterError.dumpErrorToConsole(details);
  };
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  ErrorWidget.builder = (details) {
    return Material(
      child: Center(
        child: Text(
          details.exceptionAsString(),
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', 'US'), Locale('th', 'TH')],
      title: 'CSSD Cleaning',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      home: const HomePage(),
    );
  }
}
