import 'package:flutter/material.dart';

import '../../../colors/colors_const.dart';
import '../../../textstyles/textstyle_const.dart';

class AddSuggestProduct extends StatelessWidget {
  const AddSuggestProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.white100),
        backgroundColor: AppColors.white20,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const CustomTextField(hinttext: "Suggest Product Name",),
            const SizedBox(height: 10,),
            const CustomTextField(hinttext: "Suggest Product Name",),
            const SizedBox(height: 10,),
            const CustomTextField(hinttext: "Locality",),
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: (){ },
              child: Container(
                height: size.height*0.05,
                width: size.width*0.4,
                decoration: BoxDecoration(
                    color: AppColors.primary700,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Center(child: Text("Submit",style: AppTextStyles.kBody15RegularTextStyle.copyWith(color: AppColors.white),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class CustomTextField extends StatelessWidget {
  final TextEditingController ?controller;
  final String hinttext;
  const CustomTextField({Key? key,  this.controller, required this.hinttext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hinttext
      ),
    );
  }
}
