import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';

class AppThemes {
  AppThemes({
    this.isDarkMode = false,
    this.primaryColor = AppColors.primary,
    this.secondaryColor = AppColors.secondary,
  }) : brightness = isDarkMode ? Brightness.dark : Brightness.light;
  static const _font = 'app.dart';

  bool isDarkMode;
  Brightness brightness;
  Color primaryColor;
  Color secondaryColor;

  Color get backgroundColor => AppColors.secondary;

  TextTheme get textTheme {
    final textColor = isDarkMode ? Colors.white : AppColors.black;
    return TextTheme(
      displayLarge: TextStyle(fontSize: 96, color: textColor),
      displayMedium: TextStyle(fontSize: 60, color: textColor),
      displaySmall: TextStyle(fontSize: 48, color: textColor),
      headlineMedium: TextStyle(fontSize: 34, color: textColor),
      headlineSmall: TextStyle(fontSize: 24, color: textColor),
      titleLarge: TextStyle(
        fontSize: 20,
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(fontSize: 16, color: textColor),
      titleSmall: TextStyle(
        fontSize: 14,
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: textColor),
      bodyMedium: TextStyle(fontSize: 14, color: textColor),
      bodySmall: TextStyle(fontSize: 12, color: textColor),
      labelLarge: TextStyle(
        fontSize: 14,
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(fontSize: 14, color: textColor),
    );
  }

  ///Light theme
  ThemeData get theme {
    return ThemeData(
      brightness: brightness,
      primaryColor: primaryColor,
      fontFamily: _font,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        color: backgroundColor,
        titleTextStyle: isDarkMode
            ? const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )
            : const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: isDarkMode ? Colors.white : Colors.black,
        labelColor: Colors.white,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      textTheme: textTheme,
      dividerTheme: const DividerThemeData(
        color: Colors.grey,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
