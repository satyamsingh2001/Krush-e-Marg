import 'package:flutter/material.dart';

class ConstantContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radiusBorder;
  final double? borderWidth;
  final Color? borderColor;
  final Color? color;
  final Color? shadowColor;
  final Widget? child;
  final double ?blurRadius;
  final double ?spreadRadius;
  final Offset ?offset;
  const ConstantContainer({
    Key? key,
    this.height,
    this.width,
    this.radiusBorder,
    this.borderWidth,
    this.color,
    this.child,
    this.borderColor,
    this.shadowColor, this.blurRadius, this.offset, this.spreadRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color,
            boxShadow: [
              BoxShadow(
                color: shadowColor?? Colors.transparent,
                blurRadius: blurRadius??1.0,
                spreadRadius: spreadRadius??0,
                offset: offset??Offset.zero,
              ),
            ],
            borderRadius: BorderRadius.circular(radiusBorder ?? 0),
            border: Border.all(
                color: borderColor ?? Colors.transparent,
                width: borderWidth ?? 0)),
        child: child);
  }
}