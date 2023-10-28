import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectDetailCard extends StatelessWidget {
  const ProjectDetailCard({
    super.key,
    required this.headline, // The headline for the card.
    required this.body, // The widget to be displayed in the card's body.
  });

  final String headline; // The headline text for the card.
  final Widget body; // The content to be displayed in the card's body.

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.r), // Add top padding to the card.
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0), // Add padding to the card's content.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(), // (Comment: It seems like there's an empty row, possibly a placeholder.)
              Text(
                headline, // Display the provided headline text.
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600), // Define text style.
              ),
              Padding(padding: EdgeInsets.only(top: 4.r), child: body), // Display the provided body content.
            ],
          ),
        ),
      ),
    );
  }
}
