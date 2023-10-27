import 'package:flutter/material.dart';

class TextRich extends StatelessWidget {
  const TextRich({
    super.key,
    required this.firstText,
    required this.secText,
    required this.style1,
    required this.style2,
  });

  final String firstText;
  final String secText;
  final TextStyle style1;
  final TextStyle style2;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: firstText,
        style: style1,
        children: <TextSpan>[TextSpan(text: secText, style: style2)],
      ),
    );
  }
}
