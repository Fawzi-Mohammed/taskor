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
    this.errorStyle,
    this.errorMaxLines,
    this.errorSpacing,
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
  final TextStyle? errorStyle;
  final int? errorMaxLines;
  final double? errorSpacing;
  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final resolvedBorderWidth = widget.borderWidth ?? 0.5;
    final resolvedBorderColor = ColorManager.subtitleAndToDoColor;
    final decoration = InputDecoration(
      suffixIconConstraints: widget.suffixIconConstraints,
      label: widget.labelText,
      hint: widget.hintText,
      prefixIcon: widget.prefixIcon,
      prefixIconConstraints: widget.prefixIconConstraints,
      errorStyle: widget.errorStyle,
      errorMaxLines: widget.errorMaxLines,
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
        borderSide: BorderSide(
          width: resolvedBorderWidth,
          color: resolvedBorderColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(
          width: resolvedBorderWidth,
          color: resolvedBorderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(
          width: resolvedBorderWidth,
          color: resolvedBorderColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(
          width: resolvedBorderWidth,
          color: resolvedBorderColor,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(
          width: resolvedBorderWidth,
          color: resolvedBorderColor,
        ),
      ),
    );

    if (widget.errorSpacing == null) {
      return TextFormField(
        maxLines: widget.maxLines,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword ? _obscureText : false,
        onFieldSubmitted: widget.onSubmitted,
        validator: widget.validator,
        enabled: widget.enabled,
        decoration: decoration,
      );
    }

    return FormField<String>(
      initialValue: widget.controller?.text ?? '',
      validator: widget.validator,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              maxLines: widget.maxLines,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: widget.isPassword ? _obscureText : false,
              onSubmitted: widget.onSubmitted,
              onChanged: state.didChange,
              enabled: widget.enabled,
              decoration: decoration,
            ),
            if (state.hasError) ...[
              SizedBox(height: widget.errorSpacing),
              Text(
                state.errorText ?? '',
                style: widget.errorStyle,
                maxLines: widget.errorMaxLines,
              ),
            ],
          ],
        );
      },
    );
  }
}
