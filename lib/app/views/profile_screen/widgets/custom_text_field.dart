import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? title;
  final bool obscureText;
  final TextStyle? titleStyle;
  final String? initialValue;
  final bool isRequired;
  final bool readonly;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? maxlines;
  final Widget? prefix;
  final Widget? suffix;
  final double padding;
  final TextInputType? keyboardType;
  const CustomTextField({
    Key? key,
    this.controller,
    this.titleStyle,
    this.validator,
    this.initialValue,
    this.obscureText = false,
    this.keyboardType,
    this.padding = 0,
    this.isRequired = false,
    this.readonly=false,
    this.title,
    this.inputFormatters,
    this.maxLength,
    this.suffix,
    this.prefix,
    this.hintText,
    this.maxlines,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Stack(
              children: [
                Text(
                  title!,
                ),
                if (isRequired)
                  const Positioned(
                    right: 0,
                    top: 2,
                    child: Icon(
                      CupertinoIcons.staroflife_fill,
                      color: Colors.red,
                      size: 8,
                    ),
                  )
              ],
            ),
          TextFormField(
            readOnly: readonly,
            initialValue: initialValue,
            controller: controller,
            inputFormatters: inputFormatters,
            maxLength: maxLength,
            maxLines: maxlines,
            keyboardType: keyboardType,
            obscureText: obscureText,
            validator: validator,
            decoration: InputDecoration(
              counterText: "",
              contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              hintText: hintText,
              border: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 1,
                ),
              ),
              suffixIcon: suffix,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.white40,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 1,
                ),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.error40,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
