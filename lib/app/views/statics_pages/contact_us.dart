import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colors/colors_const.dart';
import '../../textstyles/textstyle_const.dart';


class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1.5,
        titleTextStyle: AppTextStyles.kHeading3TextStyle.copyWith(color: AppColors.white90),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_rounded,color: AppColors.white90,)),
        backgroundColor: AppColors.white10,
        centerTitle: true,
        title: const Text("Contact Us"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            constColumn("First Name", Icons.person, "Enter First Name"),
            constColumn("Last Name", Icons.person, "Enter Last Name"),
            constColumn("Mobile", Icons.phone, "Enter Mobile Number"),
            constColumn("Email", Icons.email, "Enter Email Id"),
            constColumn("Location", Icons.location_on, "Enter Location"),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Description",
                  style: AppTextStyles.kCaption12RegularTextStyle
                      .copyWith(color: AppColors.white90),
                ),
                const SizedBox(
                  height: 5,
                ),
                const ConstTextField(
                  prefixicon: Icons.chat,
                  hintext: "Write Something here",
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: InkWell(
                    onTap: (){},
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                     width: 150,
                     decoration: BoxDecoration(
                       color: AppColors.success40,
                       borderRadius: BorderRadius.circular(3),
                     ),
                      child: Text("Submit", style: AppTextStyles.kBody15SemiboldTextStyle
                          .copyWith(color: AppColors.white)),
                    ),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }

  Widget constColumn(final name, prefixicon, hinttext) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name + "*",
          style: AppTextStyles.kCaption12RegularTextStyle
              .copyWith(color: AppColors.white90),
        ),
        const SizedBox(
          height: 5,
        ),
        ConstTextField(
          prefixicon: prefixicon,
          hintext: hinttext,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class ConstTextField extends StatelessWidget {
  final IconData prefixicon;
  final String hintext;
  final int? maxline;
  const ConstTextField(
      {Key? key, required this.prefixicon, required this.hintext, this.maxline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxline,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary)
        ),
        prefixIcon: Icon(prefixicon,color: AppColors.primary,),
        hintText: hintext,
        contentPadding: const EdgeInsets.all(10)
      ),
    );
  }
}
