import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  const CustomWidget({
    required this.param,
    super.key,
    this.onPressed,
  });
  final String param;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
