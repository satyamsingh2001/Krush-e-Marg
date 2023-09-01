import 'package:flutter/material.dart';
import '../colors/colors_const.dart';

class ContainerWidget extends StatefulWidget {
  double? height;
  double? width;
  final Widget? child;
  ContainerWidget({Key? key, required this.child,this.height,this.width}) : super(key: key);

  @override
  State<ContainerWidget> createState() => _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: AppColors.white,
          border:
          Border.all(color: AppColors.white30, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: widget.child);
  }
}
