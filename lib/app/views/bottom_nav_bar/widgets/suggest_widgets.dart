import 'package:flutter/material.dart';
import 'package:krush_e_marg/app/views/bottom_nav_bar/widgets/add_suggest_product.dart';

import '../../../colors/colors_const.dart';
import '../../../textstyles/textstyle_const.dart';

class SuggestWidget extends StatelessWidget {
  const SuggestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height*.35,
      width: size.width,
      color: AppColors.white20,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Text(
              "Didn't find\nWhat you were\nlooking for",
              style: AppTextStyles.kHeading2TextStyle
                  .copyWith(color: AppColors.white60),
            ),
            const SizedBox(height: 10,),
            Text(
              "We'll try to help you find\nwhat you're looking for",
              style: AppTextStyles.kBody15RegularTextStyle
                  .copyWith(color: AppColors.white50),
            ),  const SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddSuggestProduct()));
              },
              child: Container(
                height: size.height*0.05,
                width: size.width*0.5,
                decoration: BoxDecoration(
                    color: AppColors.primary700,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.add_box_rounded,color: AppColors.white,),
                    Text("Suggest Product",style: AppTextStyles.kCaption12SemiboldTextStyle.copyWith(color: AppColors.white),),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
