import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../colors/colors_const.dart';
import 'newhomeaddress.dart';
class AlertPage extends StatelessWidget {
  const AlertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        color: AppColors.white,
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/find.png',height: 200,width: 200,),
            const SizedBox(height: 10,),
            const Text(
              textAlign: TextAlign.center,
                "Sorry,we don't deliver at\n your location",style: AppTextStyles.kHeading3TextStyle, ),
            const SizedBox(height: 10,),
            Text(
              textAlign: TextAlign.center,
              "we will be there soon- hang on tight!",style: AppTextStyles.kCaption12RegularTextStyle.copyWith(color: AppColors.white50), ),
            TextButton(onPressed: (){
              Get.offAll(const NewHomePageAddress());
            }, child: const Text('Change Address'))
          ],
        ),
      ),
    );
  }
}
