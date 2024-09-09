import 'package:flutter/material.dart';

class ExpandedButton extends StatelessWidget {
  final Widget child;
  final Color? color;
  final IconData? icon;
  final void Function()? onPressed;
  const ExpandedButton(
      {super.key,
      required this.child,
      required this.onPressed,
      this.color,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MaterialButton(
            color: color ?? Colors.blue,
            onPressed: onPressed,
            textTheme: ButtonTextTheme.primary,
            textColor: Colors.white,
            splashColor: Colors.blue.shade400,
            elevation: 10,
            highlightElevation: 20,
            disabledElevation: 5.0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  7.0,
                ),
              ),
            ),
            height: 44.0,
            minWidth: 140,
            child: child,
          ),
        ),
      ],
    );
  }
}
