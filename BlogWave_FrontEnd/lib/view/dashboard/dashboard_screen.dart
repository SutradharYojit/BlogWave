import 'package:flutter/material.dart';
import '../../resources/resources.dart';
import '../view.dart';

// Create a ValueNotifier to keep track of the selected screen index.
final ValueNotifier<int> _screenIndex = ValueNotifier(0);

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  // Define a list of screens that will be displayed in the bottom navigation bar.
  final List<Widget> _screens = [
    const PortfolioScreen(), // Portfolio screen.
    const BlogListingScreen(), // Blog listing screen.
    const UserProfileScreen(), // User profile screen.
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _screenIndex,
        builder: (context, value, child) {
          return _screens[value]; // Display the selected screen based on the current value of _screenIndex.
        },
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _screenIndex,
        builder: (context, value, child) {
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle_outlined),
                label: StringManager.portfolioScreen,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.article_outlined),
                label: StringManager.blogScreen,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.portrait_rounded),
                label: StringManager.profileScreen,
              ),
            ],
            currentIndex: value, // Set the current index based on the value of _screenIndex.
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            iconSize: 35,
            elevation: 10,
            onTap: (value) {
              _screenIndex.value = value; // Update the selected screen index when a new screen is tapped.
            },
          );
        },
      ),
    );
  }
}
