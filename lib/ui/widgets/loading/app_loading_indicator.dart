import 'package:flutter/material.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  const AppCircularProgressIndicator({
    super.key,
    this.valueColor = const Color(0xFFC90003),
    this.backgroundColor = Colors.white,
  });
  final Color valueColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          backgroundColor: backgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(valueColor),
          strokeWidth: 2,
        ),
      ),
    );
  }
}
