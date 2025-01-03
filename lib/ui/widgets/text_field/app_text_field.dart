import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.controller,
    super.key,
    this.onChanged,
    this.onFieldSubmitted,
    this.hintText,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.hintStyle,
    this.style,
    this.focusedColor,
    this.padding,
    this.errorStyle,
    this.validator,
    this.keyboardType,
    this.inputFormatters = const [],
    this.enable = true,
  });
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final String? hintText;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final Color? focusedColor;
  final EdgeInsets? padding;
  final TextStyle? errorStyle;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      style: style ?? AppTextStyle.blackS14,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        filled: true,
        fillColor: enable ? Colors.transparent : AppColors.inputDisabled,
        contentPadding:
            padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        hintText: hintText,
        hintStyle: hintStyle ?? AppTextStyle.grayS14,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.secondary),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.inputBorder),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.inputBorder),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.error),
        ),
        errorStyle: errorStyle ??
            AppTextStyle.blackS12.copyWith(color: AppColors.error),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      keyboardType: keyboardType,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      enabled: enable,
    );
  }
}
