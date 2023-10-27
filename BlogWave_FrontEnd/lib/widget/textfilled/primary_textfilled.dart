
import 'package:flutter/material.dart';

import '../../resources/resources.dart';
// this primary textfilled where we use this in all over the app
class PrimaryTextFilled extends StatelessWidget {
  const PrimaryTextFilled({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.maxLines,
    this.autofocus,
    this.prefixText,
    this.maxLength,
    this.readOnly,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.textCapitalization,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final bool? autofocus;
  final bool? readOnly;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      readOnly: readOnly ?? false,
      autofocus: autofocus ?? false,
      controller: controller,
      textCapitalization: textCapitalization??TextCapitalization.none,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction?? TextInputAction.next,
      keyboardType: keyboardType,
      maxLines: maxLines ?? null,
      maxLength: maxLength,
      decoration: InputDecoration(
          prefixText: prefixText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: labelText,
          hintText: hintText,
          enabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(),
          // border: buildOutlineInputBorder(),
          errorBorder: buildOutlineInputBorder(),
          focusedErrorBorder: buildOutlineInputBorder()),
    );
  }
}

OutlineInputBorder buildOutlineInputBorder() {
  return OutlineInputBorder(
    borderSide:   const BorderSide(color: ColorManager.gradientDarkTealColor),
    borderRadius: BorderRadius.circular(15),
  );
}
