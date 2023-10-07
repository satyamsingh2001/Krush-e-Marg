import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krush_e_marg/app/auth/welcomeScreen.dart';
import 'package:krush_e_marg/app/controller/api_controller.dart';
import 'package:krush_e_marg/app/views/bottom_nav_bar/community/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../colors/colors_const.dart';
import '../../constwidgets/const_container.dart';
import '../../textstyles/textstyle_const.dart';
import '../CheckoutScreen/screens/addnewaddress.dart';

class ConstDrawer extends StatefulWidget {
  const ConstDrawer({Key? key}) : super(key: key);

  @override
  State<ConstDrawer> createState() => _ConstDrawerState();
}

class _ConstDrawerState extends State<ConstDrawer> {

  final UpdateController updateController = Get.find();


  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateController>(
      builder: (updateController) {
        return Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                height: 100,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.white30,
                      child: Icon(Icons.person,color: AppColors.primary,),
                    ),
                    title: Text(
                      updateController.updateList.isNotEmpty?updateController.updateList['f_name'].toString():"Update yor name",
                      // "Satyam Singh",
                      style: AppTextStyles.kBody15SemiboldTextStyle
                          .copyWith(color: AppColors.white80),
                    ),
                    subtitle: Text(
                      updateController.updateList.isNotEmpty
                          ? updateController.updateList['phone'] != null
                          ? updateController.updateList['phone'].toString()
                          : (updateController.updateList['email'] != null
                          ? updateController.updateList['email'].toString()
                          : "Update your information")
                          : "Update your information",
                      style: AppTextStyles.kCaption12RegularTextStyle.copyWith(
                        color: AppColors.white80,
                      ),
                    ),

                  )),
              // constListTile(Icons.home, "Home", () {
              //   Get.back();
              // }),
              constListTile(Icons.list_alt, "My Order", () {}),
              constListTile(Icons.location_on_outlined, "My Address", () {
                Get.to(const AddNewAddresMap());
              }),
              constListTile(Icons.language_rounded, "Languages", () {}),
              constListTile(CupertinoIcons.text_badge_star, "Test Documents", () {}),
              constListTile(Icons.share, "Share App", () {
                shareContent();
              }),
              constListTile(Icons.star_rate, "Rate Us", () {}),
              constListTile(Icons.support_agent_rounded, "Contact Us", () {}),
              constListTile(Icons.travel_explore_rounded, "About", () {}),
              constListTile(Icons.logout, "Logout", () {
                dialogBox(
                  context,
                  "Do you really want to Logout?",
                  "",
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary),
                    child: const Text('Confirm'),
                    onPressed: () async{
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.clear();
                      FirebaseAuth.instance.signOut();
                      Get.offAll(const WelcomeScreen());
                    },
                  ),
                );
              }),
            ],
          ),
        );
      }
    );
  }

  Widget constListTile(leadingIcon, titleText, onTap) {
    return Column(
      children: [
        const ConstantContainer(
          height: 0.1,
          color: AppColors.white60,
        ),
        ListTile(
            leading: CircleAvatar(
                backgroundColor: AppColors.white30,
                child: Icon(
                  leadingIcon,
                  color: AppColors.primary,
                )),
            title: Text(titleText),
            onTap: onTap),
      ],
    );
  }
}
