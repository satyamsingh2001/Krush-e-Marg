import 'package:flutter/material.dart';

import '../colors/colors_const.dart';
import '../textstyles/textstyle_const.dart';

class ConstTextField extends StatelessWidget {
  final TextStyle? style;
  final TextStyle? hintStyle;
  final Color? enableBorderColor;
  final TextEditingController ?controller;
  final Widget? suffix;
  final TextInputType? inputType;
  final int? maxLength;
  final int? maxLine;
  final String hintText;
  final bool ?obscure;
  final bool ?readyOnly;
  final IconButton? suffixIcon;
  final FormFieldValidator? validator;
  final EdgeInsetsGeometry? contentPadding;
  final VoidCallback ?onTap;
  final ValueChanged<String>? onChanged;


   const ConstTextField(
      {Key? key,
        this.controller,
        this.inputType,
        this.maxLength,
        required this.hintText,
        this.suffixIcon,
        this.validator,
        this.obscure, this.contentPadding, this.maxLine, this.readyOnly, this.suffix, this.onTap, this.style, this.enableBorderColor, this.hintStyle, this.onChanged, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: TextFormField(
        onTap: onTap,
        readOnly: readyOnly??false,
        validator: validator,
        controller: controller,
        onChanged: onChanged,
        keyboardType: inputType,
        obscureText: obscure??false,
        cursorColor: AppColors.primary,
        maxLength: maxLength,
        maxLines: maxLine,
        cursorHeight: 20,
        style:style ?? AppTextStyles.kBody17SemiboldTextStyle
            .copyWith(color: AppColors.primary),
        decoration: InputDecoration(
          suffix: suffix,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle:  hintStyle??AppTextStyles.kCaption12RegularTextStyle
              .copyWith(color: AppColors.white50),
          counter: const Offstage(),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color:enableBorderColor??AppColors.white60 ,width: 1),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: AppColors.primary, width: 1),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.white60),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Color(0xFFF65054)),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Color(0xFFF65054)),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal : 8),
        ),
      ),
    );
  }
}