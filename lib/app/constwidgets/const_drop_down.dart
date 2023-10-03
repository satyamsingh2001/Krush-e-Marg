import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../colors/colors_const.dart';
import '../textstyles/textstyle_const.dart';

class ConstantDropdown extends StatefulWidget {
  final List options;
  final ValueChanged onChanged;
  final Color iconColor;
  final Color dropdownColor;
  final Color textColor;
  final String hint;

  const ConstantDropdown({super.key,
    required this.options,
    required this.onChanged,
    required this.iconColor,
    required this.dropdownColor,
    required this.textColor,
    required this.hint,
  });

  @override
  State<ConstantDropdown> createState() => _ConstantDropdownState();
}

class _ConstantDropdownState extends State<ConstantDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<String>(
        hint: Text(widget.hint,style: AppTextStyles.kCaption12SemiboldTextStyle
            .copyWith(color: AppColors.white50)),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
          border:  OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.white60)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.white60,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primary,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select value';
          }
          return null;
        },
        dropdownColor: widget.dropdownColor,
        value: null,
        onChanged: widget.onChanged,
        // icon: const Icon(CupertinoIcons.chevron_down),
        // iconSize: 15,
        iconEnabledColor: widget.iconColor,
        items: widget.options.map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(
              value,
              style: AppTextStyles.kBody15SemiboldTextStyle
                  .copyWith(color: widget.textColor),
            ),
          );
        }).toList(),
      ),
    );
  }
}