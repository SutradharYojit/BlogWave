import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// pop menu button used in blog listing card to edit and delete
class PopMenuBtn extends StatelessWidget {
  const PopMenuBtn({super.key, required this.title, required this.icon});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 10.r),
          child: Text(title),
        ),
      ],
    );
  }
}
