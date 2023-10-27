import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/resources.dart';

// primary appbar title with app icon and used in porfolio screen and contact screen
class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
    required this.title
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          IconAssets.appIcon,
          height: 33.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.0.r),
          child: Text(
            title,
            style: TextStyle(fontSize: 15.sp),
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
