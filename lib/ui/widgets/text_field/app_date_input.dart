import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/configs/app_configs.dart';
import 'package:flutter_base/ui/widgets/picker/app_date_picker.dart';
import 'package:flutter_base/utils/app_date_utils.dart';

class AppDateInput extends StatelessWidget {
  const AppDateInput({
    required this.controller,
    super.key,
    this.maxDate,
    this.minDate,
    this.dateFormatter = AppConfigs.dateDisplayFormat,
    this.onChanged,
    this.onFieldSubmitted,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.hintStyle,
    this.style,
    this.padding,
    this.errorStyle,
    this.validator,
    this.enable = true,
  });
  final TextEditingController controller;
  final DateTime? maxDate;
  final DateTime? minDate;
  final String dateFormatter;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final EdgeInsets? padding;
  final TextStyle? errorStyle;
  final String? Function(String?)? validator;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: () async {
        final date = controller.text.isNotEmpty
            ? AppDateUtils.fromString(
                controller.text,
                format: dateFormatter,
              )
            : DateTime.now();
        final pickedDate = await AppDatePicker.pickDate(
          context,
          initialDate: date,
          maxDate: maxDate,
          minDate: minDate,
        );

        if (pickedDate != null) {
          controller.text = AppDateUtils.toDateString(
            pickedDate,
            format: dateFormatter,
          );
        }
      },
      controller: controller,
      style: style ?? AppTextStyle.blackS14,
      decoration: InputDecoration(
        filled: true,
        fillColor: enable ? Colors.transparent : AppColors.inputDisabled,
        contentPadding:
            padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        hintText: hintText,
        hintStyle: hintStyle ?? AppTextStyle.grayS14,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.inputBorder),
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
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      enabled: enable,
    );
  }
}
