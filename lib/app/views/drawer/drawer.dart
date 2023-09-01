import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colors/colors_const.dart';
import '../../constwidgets/const_container.dart';
import '../../textstyles/textstyle_const.dart';

class ConstDrawer extends StatelessWidget {
  const ConstDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  "Satyam Singh",
                  style: AppTextStyles.kBody15SemiboldTextStyle
                      .copyWith(color: AppColors.white80),
                ),
                subtitle: Text(
                  "1234567890",
                  style: AppTextStyles.kCaption12RegularTextStyle
                      .copyWith(color: AppColors.white80),
                ),
              )),
          constListTile(Icons.home, "Home", () {
            Get.back();
          }),
          constListTile(Icons.list_alt, "My Order", () {}),
          constListTile(Icons.location_on_outlined, "My Address", () {}),
          constListTile(Icons.language_rounded, "Languages", () {}),
          constListTile(CupertinoIcons.text_badge_star, "Test Documents", () {}),
          constListTile(Icons.share, "Share App", () {}),
          constListTile(Icons.star_rate, "Rate Us", () {}),
          constListTile(Icons.support_agent_rounded, "Contact Us", () {}),
          constListTile(Icons.travel_explore_rounded, "About", () {}),
          constListTile(Icons.logout, "Logout", () {}),
        ],
      ),
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
