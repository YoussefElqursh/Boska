import 'package:flutter/material.dart';

MaterialButton buildMaterialButton({
  required BuildContext context,
  required String label,
  required void Function()? onPressed,
  Color? color,
  Color? textColor = Colors.white,
  EdgeInsetsGeometry? padding = const EdgeInsets.all(20.0),
  ShapeBorder? shape,
  double? width,
}) {
  return MaterialButton(
    onPressed: onPressed,
    color: color,
    padding: padding,
    minWidth: width,
    shape: shape,
    highlightElevation: 0.0,
    child: Text(
      label,
      style: TextStyle(
        color: textColor,
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
