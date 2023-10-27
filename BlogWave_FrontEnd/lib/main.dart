import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'firebase_options.dart';

// Initializes Firebase, sets up image caching, and starts the app.
Future main() async {
  // Set the log level for CachedNetworkImage to debug.
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  // Ensure Flutter is initialized and ready to run.
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase with the default Firebase options for the current platform.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Run the Flutter app wrapped in a ProviderScope for state management.
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

