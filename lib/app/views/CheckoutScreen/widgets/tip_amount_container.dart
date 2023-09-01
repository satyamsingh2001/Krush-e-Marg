import 'package:flutter/material.dart';

import '../../../colors/colors_const.dart';
import '../../../textstyles/textstyle_const.dart';

class TipAmountContainer extends StatelessWidget {
  final int amount;
  final bool isSelected;
  final VoidCallback onTap;
  final String img;

  const TipAmountContainer({
    super.key,
    required this.amount,
    required this.isSelected,
    required this.onTap,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 60,
        alignment: Alignment.center,
        // padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(14),
          color: isSelected ? AppColors.success20 : AppColors.white10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              img,
              height: 20,
              width: 20,
            ),
            Text(
              '₹$amount',
              style: AppTextStyles.kCaption12SemiboldTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}