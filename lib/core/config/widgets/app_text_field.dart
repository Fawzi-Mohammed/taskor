import 'package:flutter/material.dart';
import 'package:taskor/core/config/constants/color_manager.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onSubmitted,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.prefixIconConstraints,
    this.borderWidth,
    this.isPassword = false,
    this.suffixIconConstraints,
  });
  final TextEditingController? controller;
  final Widget? hintText;
  final Widget? labelText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onSubmitted;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final BoxConstraints? prefixIconConstraints;
  final double? borderWidth;
  final bool isPassword;
  final BoxConstraints? suffixIconConstraints;
  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final resolvedBorderWidth = widget.borderWidth ?? 0.5;
    return TextFormField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? _obscureText : false,
      onFieldSubmitted: widget.onSubmitted,
      validator: widget.validator,
      enabled: widget.enabled,

      decoration: InputDecoration(
        suffixIconConstraints: widget.suffixIconConstraints,
        label: widget.labelText,
        hint: widget.hintText,
        prefixIcon: widget.prefixIcon,
        prefixIconConstraints: widget.prefixIconConstraints,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () => setState(() => _obscureText = !_obscureText),
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: ColorManager.primary,
                ),
              )
            : widget.suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(width: resolvedBorderWidth),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(width: resolvedBorderWidth),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(width: resolvedBorderWidth),
        ),
      ),
    );
  }
}
