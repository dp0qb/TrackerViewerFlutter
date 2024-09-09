import 'package:flutter/material.dart';

class ExpandedButton extends StatelessWidget {
  final IconData? icon;
  final String labelStr;
  final void Function()? onPressed;
  const ExpandedButton(
      {super.key, required this.labelStr, required this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: const ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          Colors.blue,
        ),
        foregroundColor: WidgetStatePropertyAll(
          Colors.white,
        ),
      ),
      icon: Icon(color: Colors.white, icon),
      onPressed: onPressed,
      label: Text(
        labelStr,
      ),
    );
  }
}
