import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../resources/resources.dart';
import '../../routes/routes_name.dart';
import '../../services/services.dart';

// Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final userPreferences = UserPreferences();

  @override
  void initState() {
    super.initState();
    userPreferences.getUserInfo();
    navigation();
  }
  void navigation() {
    Duration duration = const Duration(seconds: 3);

    Future.delayed(
      duration,
          () {
        if (UserPreferences.loggedIn == true) {
          // If the user is logged in, navigate to the dashboard screen.
          log(UserPreferences.userId.toString());
          context.go(RoutesName.dashboardScreen);
        } else {
          // If the user is not logged in, navigate to the login screen.
          context.go(RoutesName.loginScreen);
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  AnimationAssets.splashAnimation,
                  height: 170.h
                ),
                Text(
                  StringManager.myApp,
                  style: TextStyle(
                    fontSize: 55.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "DancingScript",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
