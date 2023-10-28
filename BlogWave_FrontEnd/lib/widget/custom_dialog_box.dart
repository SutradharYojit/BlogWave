import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/color_manager.dart';
Future<dynamic> dialogBox(
    BuildContext context, {
      required String headLine, // Dialog headline
      required String button, // Text on the action button
      required VoidCallback onPressed, // Callback when the action button is pressed
    }) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialogBox(
        headLine: headLine,
        button: button,
        onPressed: onPressed,
      );
    },
  );
}

class CustomDialogBox extends StatelessWidget {
  const CustomDialogBox({
    super.key,
    required this.headLine, // Headline text to display
    required this.button, // Text on the action button
    required this.onPressed, // Callback when the action button is pressed
  });

  final VoidCallback onPressed;
  final String headLine;
  final String button;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorManager.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(const Radius.circular(20.0).w)),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              headLine, // Display the provided headline
              style: TextStyle(fontSize: 15.sp),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(90.w, 20.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20).w),
                  ),
                  onPressed: onPressed, // Execute the provided callback
                  child: Text(
                    button, // Display the provided button text
                    style: TextStyle(fontSize: 13.sp),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(90.w, 20.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20).w),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text(
                    "Close", // Close button text
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

