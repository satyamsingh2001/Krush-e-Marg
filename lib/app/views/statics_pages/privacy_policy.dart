import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colors/colors_const.dart';
import '../../textstyles/textstyle_const.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 1.5,
        titleTextStyle: AppTextStyles.kHeading3TextStyle.copyWith(color: AppColors.white90),
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: const Icon(Icons.arrow_back_rounded,color: AppColors.white90,)),
        backgroundColor: AppColors.white10,
        centerTitle: true,
        title: const Text("Privacy Policy"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),

              Text(
                textAlign: TextAlign.justify,
"krush_e_marg (Formally known as FSTMD Private Limited), a private limited company with its registered office at '169, Nanakmatta, Udham Singh Nagar, Uttarakhand, India -262311 (â€œCompanyâ€" "Our" "and terms of similar meaning) is committed to protecting your privacy. This Privacy Policy shall apply to the user/users. For the purposes of this Privacy Policy, Users shall together hereinafter be referred to as â€œYouâ€, â€œYourâ€ or â€œYourself â€д.",              style: AppTextStyles.kBody15RegularTextStyle
                    .copyWith(color: AppColors.white100),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                  "1. Our Statement of Privacy Practice",
                  style: AppTextStyles.kBody17SemiboldTextStyle.copyWith(
                    color: AppColors.white100,
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(
                textAlign: TextAlign.justify,
". Your information is collected and processed in accordance with the terms and conditions of this Privacy Policy.",
                style: AppTextStyles.kBody15RegularTextStyle
                    .copyWith(color: AppColors.white100),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                  "2.Collection of Information",
                  style: AppTextStyles.kBody17SemiboldTextStyle.copyWith(
                    color: AppColors.white100,
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(
                textAlign: TextAlign.justify,
"Information You give Us: In order to provide our full range of Services, We may collect the following types of information from You (as applicable) including but not limited to: Your name, gender, email address, mobile and/or telephone numbers, service address, date of birth, profile picture, contact details of people You refer to Us and other information about the service address that you give us, the information provided by You while initiating and running a task, including, without limitation: search words, location, products or services being sought, reviews, rating, order details, and history, pictures of items ordered or for which a task is run and all chat history, etc. We may further collect medical information in the form of medical prescriptions or other similar such documents from You, depending on the nature of product or service sought through the Platform, to initiate a transaction on the Platform, and share such information on a need-to-know",              style: AppTextStyles.kBody15RegularTextStyle
                    .copyWith(color: AppColors.white100),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
