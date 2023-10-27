 // Importing necessary packages and resources
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/resources.dart';
import '../routes/route.dart';

// Define the main application class
class MyApp extends StatelessWidget {
  // Constructor for the MyApp class
  const MyApp({super.key});

  // Build method for the application widget
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: ColorManager.gradientDarkTealColor),
            fontFamily: "PrimaryFonts",
            cardTheme: const CardTheme(
              surfaceTintColor: ColorManager.whiteColor,
            ),
            scaffoldBackgroundColor: ColorManager.whiteColor,
          ),
          routerConfig: router, // Define the app's router configuration
        );
      },
    );
  }
}