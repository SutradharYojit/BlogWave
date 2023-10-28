// Importing necessary packages and resources
import 'package:flutter/material.dart';  // Import the Flutter material package for building UI
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import the Flutter ScreenUtil package for responsive design
import '../resources/resources.dart';  // Import your resource file
import '../routes/route.dart';  // Import your route configuration

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
          debugShowCheckedModeBanner: false,  // Disable the debug banner
          theme: ThemeData(
            useMaterial3: true,  // Enable Material 3 design
            colorScheme: ColorScheme.fromSeed(seedColor: ColorManager.gradientDarkTealColor),  // Define the color scheme
            fontFamily: "PrimaryFonts",  // Set the primary font family
            cardTheme: const CardTheme(
              surfaceTintColor: ColorManager.whiteColor,  // Define card theme properties
            ),
            scaffoldBackgroundColor: ColorManager.whiteColor,  // Set the scaffold background color
          ),
          routerConfig: router,  // Define the app's router configuration
        );
      },
    );
  }
}
