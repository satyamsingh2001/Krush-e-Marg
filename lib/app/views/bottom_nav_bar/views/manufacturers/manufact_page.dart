import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krush_e_marg/app/views/bottom_nav_bar/views/manufacturers/controller/manuf_controller.dart';

import '../../../../colors/colors_const.dart';
import '../../../../textstyles/textstyle_const.dart';

class ManuFactPage extends StatefulWidget {
  const ManuFactPage({Key? key}) : super(key: key);

  @override
  State<ManuFactPage> createState() => _ManuFactPageState();
}

class _ManuFactPageState extends State<ManuFactPage> {
  final ManufacturersController manufacturersController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // manufacturersController.fetchManu();
  }
  @override
  Widget build(BuildContext context) {
    return   GetBuilder<ManufacturersController>(
      builder: (manufacturersController) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 0.9),
          itemCount: manufacturersController.manuList.length,
          itemBuilder: (context, index) {
            final manu = manufacturersController.manuList[index];
            return GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.white20,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 0.5, color: AppColors.primary)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child:   CachedNetworkImage(
                        imageUrl:   manu['aadhar_img_url'].toString(),
                        // placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        width: 80, // Specify the desired width
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      manu['name'].toString().capitalizeFirst!,
                      style: AppTextStyles.kCaption12SemiboldTextStyle
                          .copyWith(color: AppColors.white100),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }
}
