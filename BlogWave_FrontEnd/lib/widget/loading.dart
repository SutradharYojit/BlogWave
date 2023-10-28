import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<dynamic> loading(BuildContext context) {
  // Show a loading dialog when this function is called
  return showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: LoadingBar(),
      );
    },
  );
}
// This is the Loading animation dialog
class LoadingBar extends StatelessWidget {
  const LoadingBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // A container with a teal background color and a circular loading animation
    return Container(
      color: Colors.teal.withOpacity(0.7),
      child: const CircularLoading(), // Display the circular loading animation
    );
  }
}

// Circular loading animation widget
class CircularLoading extends StatelessWidget {
  const CircularLoading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Display a circular loading animation with SpinKitFoldingCube
    return const Center(
      child: SpinKitFoldingCube(
        color: Colors.black, // Loading animation color
        size: 45, // Loading animation size
      ),
    );
  }
}
