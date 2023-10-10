import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
import 'package:krush_e_marg/app/views/bottom_nav_bar/community/utils/utils.dart';
import 'package:krush_e_marg/app/views/bottom_nav_bar/widgets/category_list.dart';

import '../../../colors/colors_const.dart';
import '../../../controller/api_controller.dart';
import '../../CheckoutScreen/views/checkout_screen.dart';
import '../../drawer/drawer.dart';
import '../../story/stories_store.dart';
import '../widgets/banner_pageview.dart';
import '../widgets/view_categories.dart';
import 'manufacturers/controller/manuf_controller.dart';
import 'manufacturers/manufact_page.dart';
import 'manufacturers/view_manufactures.dart';
import 'recom_prod/controller/recom_controller.dart';
import 'recom_prod/rec_prod.dart';
import 'top_sellling/controller/top_selling_controller.dart';
import 'top_sellling/top_sell_page.dart';
import 'weather/controller/location_controller.dart';
import 'weather/controller/weather_controller.dart';
import 'weather/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadStrings();
      updateController.fetchUpdates();
      storyController.fetchStory();
      categoriesController.fetchCat();
      recPController.fetchRecP();
      topSellingController.fetchTopSell();
      manufacturersController.fetchManu();
      weatherController.fetchCurrentWeatherData();
      // weatherController.fetchHourlyWeather();
      locationController.requestLocationPermissions();
      locationController.getCurrentLocation();
      addressController.fetchSavedAddress();
      storyController.fetchStory();
    });
  }

  final TopSellingController topSellingController = Get.put(TopSellingController());
  final ManufacturersController manufacturersController = Get.put(ManufacturersController());
  final SubCatController subCatController = Get.put(SubCatController());
  final RecPController recPController = Get.put(RecPController());
  final CategoriesController categoriesController = Get.put(CategoriesController());
  final LocationController locationController = Get.put(LocationController());
  final AddressController addressController = Get.put(AddressController());
  final StoryController storyController = Get.put(StoryController());
  final UpdateController updateController = Get.put(UpdateController());
  final BannerController bannerController = Get.put(BannerController());
  final WeatherController weatherController = Get.find();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ConstDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Krush e Marge'),
        actions: [
          // InkWell(
          //     onTap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => const DashBoardScreenMain(
          //                     currentIndex: 1,
          //                   )));
          //     },
          //     child: const Icon(Icons.search)),
          const SizedBox(
            width: 10,
          ),
          InkWell(onTap: () {}, child: const Icon(Icons.notifications)),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(onTap: () {
            Get.to(const CheckoutScreeen());
          }, child: const Icon(Icons.shopping_cart)),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body:
          GetBuilder<CategoriesController>(
            builder: (weatherController) {
              return   categoriesController.categoriesList.isNotEmpty? Stack(
        children: [
              NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  notification.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
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
                       const BannerPageView(
                        place: "home_top",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      //categories
                      title('Categories', () {
                        Get.to(const ViewCategoryList());
                      },"View All"),
                      const CategoryList(),
                      const WeatherCondition(),

                      const SizedBox(
                        // height: 10,
                      ),
                      //recommended product
                      title('Recommended Products', () {},""),
                      const RecProductPage(),
                      title('Manufacturers', () {
                        Get.to(const ViewManufacturer());
                      },"View All"),
                      const ManuFactPage(),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                       const BannerPageView(
                        place: "home_bottom",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      title('Top Selling Products', () {
                      },""),
                      const TopSellingPage(),

                    ],
                  ),
                ),
              ),
        ],
      ):circularIndicator();
            }
          ),
    );
  }

  Widget title(String title, VoidCallback onTap,view) {
    return Column(
      children: [
        const Divider(
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.kBody15SemiboldTextStyle,
              ),
              TextButton(
                  onPressed: onTap,
                  child: Text(
                    view,
                    style: AppTextStyles.kCaption12RegularTextStyle
                        .copyWith(color: AppColors.primary),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
