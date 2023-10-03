import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConstAlert extends StatelessWidget {
  final String addedStore;
  final String toAddStore;
  final VoidCallback? replaceOntap;
  const ConstAlert({Key? key, required this.addedStore, required this.toAddStore, this.replaceOntap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Replace cart items?',style: AppTextStyles.kBody20SemiboldTextStyle.copyWith(color: AppColors.white100),),
            SizedBox(height: 10,),
            RichText(
              // textAlign: TextAlign.start,
        text: TextSpan(
        style: AppTextStyles.kCaption12SemiboldTextStyle.copyWith(color: AppColors.white70),
        children: <TextSpan>[
          const TextSpan(text: 'Your cart contains some product from '),
          TextSpan(
            text: '$addedStore.',
            style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white90),
          ),
          const TextSpan(text: 'Do you want to discard the selection and add product from '),
          TextSpan(
            text: '$toAddStore?',
            style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white90),
          ),
        ],
      ),
    ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomBtn(btnTitle: 'No', onTap: () { Get.back(); }, btnColor: AppColors.error20,),
                CustomBtn(btnTitle: 'Replace', onTap: replaceOntap!, btnColor: AppColors.success20,)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomBtn extends StatelessWidget {
  final String btnTitle;
  final VoidCallback onTap;
  final Color btnColor;
  const CustomBtn({Key? key, required this.btnTitle, required this.onTap, required this.btnColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 45,
        width: 100,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(btnTitle,style: AppTextStyles.kBody15SemiboldTextStyle),
      ),
    );
  }
}

