import 'package:flutter/material.dart';

import '../../../colors/colors_const.dart';
import '../../../textstyles/textstyle_const.dart';
import '../../story/stories_store.dart';
import '../bottom_nav_bar.dart';
import '../widgets/banner_pageview.dart';

class BottomProductPage extends StatefulWidget {
  const BottomProductPage({Key? key}) : super(key: key);

  @override
  State<BottomProductPage> createState() => _BottomProductState();
}

class _BottomProductState extends State<BottomProductPage> {

  List suraj = [
    'Shop',
    'Crop Practices',
    'Crop Advisory',
    'Crop Care',
    'Soil Testing',
    'Community',
    'Videos',
    'News',
    'Blog',
    'Weather',
    'Market Price'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Krush e Marge'),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashBoardScreenMain(
                              currentIndex: 1,
                            )));
              },
              child: const Icon(Icons.search)),
          const SizedBox(
            width: 10,
          ),
          InkWell(onTap: () {}, child: const Icon(Icons.notifications)),
          const SizedBox(
            width: 10,
          ),
          InkWell(onTap: () {}, child: const Icon(Icons.shopping_cart)),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          const StoriesStore(),
          const Divider(
            color: AppColors.white30,
            thickness: 1,
          ),
          const SizedBox(
            height: 15,
          ),
          const BannerPageView(),
          SizedBox(
            height: 15,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 0.9),
            itemCount: suraj.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8.0), // Adjust the radius as needed
                  ),
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          'assets/test_img/img_5.png',
                          height: 80,
                          width: 80,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(
                        suraj[index],
                        style: AppTextStyles.kCaption12SemiboldTextStyle
                            .copyWith(color: AppColors.white100),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
