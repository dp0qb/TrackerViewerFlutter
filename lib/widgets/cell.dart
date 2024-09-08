import 'package:flutter/material.dart';

class Cell extends StatefulWidget {
  final Widget child;
  final Color? backgroundColor;
  const Cell({super.key, required this.child, this.backgroundColor});

  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.backgroundColor ?? Colors.lightGreen.shade100,
      ),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      child: widget.child,
    );
  }
}
