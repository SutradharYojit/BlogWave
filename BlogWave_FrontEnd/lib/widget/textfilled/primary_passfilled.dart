import 'package:flutter/material.dart';

import 'primary_textfilled.dart';

// this is login and signup screen password text field
class PrimaryPassField extends StatefulWidget {
  final TextEditingController textPassCtrl;
  final String hintText;
  final String labelText;
  final Widget? prefixIcon;
  final String? Function(String?)?validator;

  const PrimaryPassField({
    super.key,
    required this.textPassCtrl,
    required this.hintText,
    required this.labelText,
    this.prefixIcon,
    this.validator
  });

  @override
  State<PrimaryPassField> createState() => _PassFieldState();
}

class _PassFieldState extends State<PrimaryPassField> {
  bool obSure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obSure,
      controller: widget.textPassCtrl,
      validator: widget.validator,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffix: GestureDetector(
            onTap: () {
              setState(() {
                obSure = !obSure;
              });
            },
            child: obSure
                ? const Icon(
                    Icons.remove_red_eye_outlined,
                  )
                : const Icon(Icons.remove_red_eye_rounded)),
        hintText: widget.hintText,
        labelText: widget.labelText,
        border: InputBorder.none,
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(),
        errorBorder: buildErrorOutlineInputBorder(),
        focusedErrorBorder: buildErrorOutlineInputBorder(),
        contentPadding: const EdgeInsets.all(17),
      ),
    );
  }
}
