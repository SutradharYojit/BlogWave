import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// this reuse widget use to scroll to the top of the screen after 1000 offset
class UpAnimation extends StatelessWidget {
  const UpAnimation({
    Key? key,
    required this.position,
    required this.scrollController,
  }) : super(key: key);

  final Animation<Offset> position;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: position,
      child: Transform.rotate(
        angle: 4.699, // Angle for the rotation of the icon
        child: IconButton.filledTonal(
          onPressed: () {
            // Scroll to the top when the button is pressed
            scrollController.animateTo(0.0, duration: const Duration(milliseconds: 500), curve: Curves.linear);
          },
          icon: const Icon(Icons.arrow_forward_ios_rounded), // Icon displayed on the button
          iconSize: 20.0, // Size of the icon
        ),
      ),
    );
  }
}

