import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krush_e_marg/app/views/bottom_nav_bar/product/soil_testing.dart';

import '../../../colors/colors_const.dart';
import '../../../const/const_string.dart';
import '../../../textstyles/textstyle_const.dart';
import '../../story/stories_store.dart';
import '../bottom_nav_bar.dart';
import '../views/weather/weatherweekly.dart';
import '../widgets/banner_pageview.dart';

class BottomProductPage extends StatefulWidget {
  const BottomProductPage({Key? key}) : super(key: key);

  @override
  State<BottomProductPage> createState() => _BottomProductState();
}

class _BottomProductState extends State<BottomProductPage> {



  List<Map<String, dynamic>> dataList = [
    {
      'title': 'Shop',
      'img': shop,
      'onTap':const DashBoardScreenMain(currentIndex: 1,),
    },
    {
      'title': 'Soil Testing',
      'img': soilTesting,
      'onTap':const SoilTesting(),
    },
    {
      'title': 'Water Test',
      'img': waterTesting,
      'onTap':const SoilTesting(),
    },
    {
      'title': 'Crop Advisory',
      'img': cropAdvisory,
      'onTap':const SoilTesting(),
    },
    {
      'title': 'Crop Care',
      'img': cropCare,
      'onTap':const SoilTesting(),
    },
    {
      'title': 'Crop Practices',
      'img': cropPractices,
      'onTap':const SoilTesting(),
    },
    {
      'title': 'Videos',
      'img': videos,
      'onTap':const SoilTesting(),
    },
    {
      'title': 'Blog',
      'img': blog,
      'onTap':const SoilTesting(),
    },
    {
      'title': 'Community',
      'img': community,
      'onTap':const DashBoardScreenMain(currentIndex: 3,),
    },
    {
      'title': 'Crop Services',
      'img': cropServices,
      'onTap':const SoilTesting(),
    },
    {
      'title': 'Weather',
      'img': weather,
      'onTap':const WeatherWeek(),
    },
    {
      'title': 'News',
      'img': news,
      'onTap':const SoilTesting(),
    },
    {
      'title': 'Crop Doctor',
      'img': cropDoctor,
      'onTap':const SoilTesting(),
    },
    {
      'title': 'Agri School',
      'img': agriSchool,
      'onTap':const SoilTesting(),
    },
    {
      'title': 'AI Farming',
      'img': aiFarming,
      'onTap':const SoilTesting(),
    },
    {
      'title': 'Kisan Dhan',
      'img': kisanDhan,
      'onTap':const SoilTesting(),
    },
    {
      'title': 'Animal Insurance',
      'img': animalInsurance,
      'onTap':const SoilTesting(),
    },
    {
      'title': 'Family Insurance',
      'img': familyInsurance,
      'onTap':const SoilTesting(),
    },
    {
      'title': 'Crop Insurance',
      'img': cropInsurance,
      'onTap':const SoilTesting(),
    },
    {
      'title': 'Government Schemes Services',
      'img': government,
      'onTap':const SoilTesting(),
    },
    {
      'title': 'New Technology',
      'img': tech,
      'onTap':const SoilTesting(),
    },
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
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: ListView(
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
            const BannerPageView(place: 'home_top',),
            const SizedBox(
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
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
               Get.off(dataList[index]['onTap']);
                    },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjust the radius as needed
                    ),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          // 'assets/test_img/img_5.png',
                          dataList[index]['img'],
                          height: 50,
                          width: 50,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          // suraj[index],
                          dataList[index]['title'],
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
      ),
    );
  }
}
