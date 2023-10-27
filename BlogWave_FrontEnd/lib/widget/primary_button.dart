import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/resources.dart';
 // Primary Liner gradient button according to project theme

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.title,
  });

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.0.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(5.w),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.w),
            gradient: const LinearGradient(
              colors: [
                Color(0xff4cd0d0),
                Color(0xff1aa6b7)
              ]
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 75.w,
              vertical: 15.w,
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                color: ColorManager.whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
