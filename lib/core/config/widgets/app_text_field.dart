import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onSubmitted,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
  });
  final TextEditingController? controller;
  final Widget? hintText;
  final Widget? labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onSubmitted;
  final bool enabled;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      enabled: enabled,
      decoration: InputDecoration(
        label: labelText,
        hint: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffix: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }
}
