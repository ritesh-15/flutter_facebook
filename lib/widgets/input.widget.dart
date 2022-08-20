// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final TextInputType textInputType;
  final String hintText;
  final String? Function(String?)? validator;
  final Icon? suffixIcon;
  final void Function()? onSuffixIconClick;
  final bool obscureText;
  final void Function(String)? onChanged;
  final int maxLines;
  final String initialValue;

  const InputWidget(
      {Key? key,
      required this.textInputType,
      required this.hintText,
      this.validator,
      this.suffixIcon,
      this.obscureText = false,
      this.onChanged,
      this.maxLines = 1,
      this.onSuffixIconClick,
      this.initialValue = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      keyboardType: textInputType,
      decoration: InputDecoration(
          errorMaxLines: 2,
          hintText: hintText,
          fillColor: Theme.of(context).cardColor,
          filled: true,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: onSuffixIconClick,
                  icon: suffixIcon!,
                )
              : null,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 0)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 0)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 0))),
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      initialValue: initialValue,
    );
  }
}
