import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
import 'package:flutter/cupertino.dart';

class CounterWidget extends StatefulWidget {
  final int? counterValue;
  final VoidCallback? minusOntap;
  final VoidCallback? plusOntap;
  final double? height;
  final double? width;
  const CounterWidget({Key? key, this.counterValue, this.minusOntap, this.plusOntap, this.height, this.width,}) : super(key: key);

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: AppColors.primary400,
        border: Border.all(
          color: AppColors.primary,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: widget.minusOntap,
              child:  SizedBox(
                height: size.height,
                width: 20,
                child: const Icon(
                  CupertinoIcons.minus,
                  color: AppColors.primary,
                  size: 15,
                ),
              )),
          Text(
            widget.counterValue.toString(),style: AppTextStyles.kBody15SemiboldTextStyle,),
          GestureDetector(
              onTap: widget.plusOntap,
              child: SizedBox(
                height: size.height,
                width: 20,
                child: const Icon(
                  CupertinoIcons.add,
                  color: AppColors.primary,
                  size: 15,
                ),
              ))
        ],
      ),
    );
  }
}