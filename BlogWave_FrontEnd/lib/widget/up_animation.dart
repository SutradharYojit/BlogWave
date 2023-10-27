import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpAnimation extends StatelessWidget {
  const UpAnimation({super.key, required this.position, required this.scrollController});

  final Animation<Offset> position;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: position,
      child: Transform.rotate(
        angle: 4.699,
        child: IconButton.filledTonal(
          onPressed: () {
            scrollController.animateTo(0.0, duration: const Duration(milliseconds: 500), curve: Curves.linear);
          },
          icon: const Icon(Icons.arrow_forward_ios_rounded),
          iconSize: 20.h,
        ),
      ),
    );
  }
}
