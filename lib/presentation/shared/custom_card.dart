import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.body,
    this.color = Colors.white,
    this.borderRadius = 20,
    this.padding = const EdgeInsets.all(0),
    this.elevation = 2,
  });

  final Color color;
  final Widget? body;
  final double borderRadius;
  final EdgeInsets padding;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: const BorderSide(color: Colors.grey), // Añadido borde gris
      ),
      child: Padding(
        padding: padding,
        child: body,
      ),
    );
  }
}
