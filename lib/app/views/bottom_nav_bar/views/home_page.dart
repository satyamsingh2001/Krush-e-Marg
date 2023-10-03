import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
import 'package:krush_e_marg/app/views/bottom_nav_bar/widgets/category_list.dart';

import '../../../colors/colors_const.dart';
import '../../../controller/api_controller.dart';
import '../../CheckoutScreen/views/checkout_screen.dart';
import '../../drawer/drawer.dart';
import '../../story/stories_store.dart';
import '../bottom_nav_bar.dart';
import '../widgets/banner_pageview.dart';
import 'manufacturers/manufact_page.dart';
import 'recom_prod/controller/recom_controller.dart';
import 'recom_prod/rec_prod.dart';
import 'top_sellling/controller/top_selling_controller.dart';
import 'top_sellling/top_sell_page.dart';
import 'weather/controller/location_controller.dart';
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
      // controller.fetchBanner();
      adminOfferController.adminOffer();
      categoriesController.fetchCat();
      // SubCatController.fetchSubCat();
      addressController.fetchSavedAddress();
      storyController.fetchStory();
      moduleController.fetchModules();
    });
  }

  // BannerController controller = Get.put(BannerController());
  final TopSellingController topSellingController = Get.put(TopSellingController());

  final SubCatController subCatController = Get.put(SubCatController());
  final RecPController recPController = Get.put(RecPController());
  AdminOfferController adminOfferController = Get.put(AdminOfferController());
  CategoriesController categoriesController = Get.put(CategoriesController());
  LocationController locationController = Get.put(LocationController());
  AddressController addressController = Get.put(AddressController());
  StoryController storyController = Get.put(StoryController());
  ModuleController moduleController = Get.put(ModuleController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ConstDrawer(),
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
          InkWell(onTap: () {
            Get.to(const CheckoutScreeen());
          }, child: const Icon(Icons.shopping_cart)),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body:
          Stack(
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
                  title('Categories', () {}),
                  const CategoryList(),
                  const SizedBox(
                    height: 10,
                  ),
                  //recommended product
                  title('Recommended Products', () {}),
                  const RecProductPage(),
                  //Top selling product
                  title('Top Selling Products', () {}),
                  const TopSellingPage(),
                  const WeatherCondition(),
                  title('Manufacturers', () {}),
                  const ManuFactPage(),
                  // GridView.builder(
                  //   shrinkWrap: true,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   padding: const EdgeInsets.all(8),
                  //   gridDelegate:
                  //       const SliverGridDelegateWithFixedCrossAxisCount(
                  //           crossAxisCount: 3,
                  //           mainAxisSpacing: 8.0,
                  //           crossAxisSpacing: 8.0,
                  //           childAspectRatio: 0.9),
                  //   itemCount: test_img.length,
                  //   itemBuilder: (context, index) {
                  //     return GestureDetector(
                  //       onTap: () {},
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //             color: AppColors.white20,
                  //             borderRadius: BorderRadius.circular(10),
                  //             border: Border.all(
                  //                 width: 0.5, color: AppColors.primary)),
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //           children: [
                  //             ClipRRect(
                  //               borderRadius: BorderRadius.circular(40),
                  //               child: Image.asset(
                  //                 test_img[index],
                  //                 height: 80,
                  //                 width: 80,
                  //                 fit: BoxFit.fill,
                  //               ),
                  //             ),
                  //             Text(
                  //               'suraj',
                  //               style: AppTextStyles.kBody17SemiboldTextStyle
                  //                   .copyWith(color: AppColors.white100),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
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
                    height: 50,
                  ),
                  // const OfferSlider(),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // const StoreModule(),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // const InviteAndShare(),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // const SuggestWidget(),
                ],
              ),
            ),
          ),
          // Positioned(
          //     top: 0,
          //     child: Container(
          //       padding: const EdgeInsets.symmetric(horizontal: 5),
          //       color: AppColors.white10,
          //       height: size.height * 0.085,
          //       width: size.width,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           GestureDetector(
          //             onTap: () {
          //               Get.to(const NewHomePageAddress());
          //             },
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 const CircleAvatar(
          //                     backgroundColor: AppColors.white30,
          //                     radius: 20,
          //                     child: Icon(
          //                       Icons.location_on,
          //                       color: AppColors.primary,
          //                     )),
          //                 SizedBox(
          //                     width: size.width * 0.13,
          //                     child: Text(
          //                       textAlign: TextAlign.center,
          //                       "Add-",
          //                       style: AppTextStyles
          //                           .kBody15SemiboldTextStyle
          //                           .copyWith(color: AppColors.white90),
          //                     )),
          //                 SizedBox(
          //                     width: size.width * 0.5,
          //                     child: GetBuilder<AddressController>(
          //                         builder: (addressController) {
          //                       return Text(
          //                         textAlign: TextAlign.start,
          //                         addressController.address.trimLeft(),
          //                         style: AppTextStyles
          //                             .kCaption12RegularTextStyle,
          //                       );
          //                     })),
          //                 const Icon(
          //                   Icons.arrow_drop_down_sharp,
          //                   size: 30,
          //                 ),
          //               ],
          //             ),
          //           ),
          //           InkWell(
          //               onTap: () {
          //                 Get.to(const CheckoutScreeen());
          //               },
          //               child: Stack(
          //                 children: [
          //                   const CircleAvatar(
          //                       backgroundColor: AppColors.white30,
          //                       radius: 20,
          //                       child: Icon(
          //                         Icons.shopping_cart_rounded,
          //                         color: AppColors.primary,
          //                       )),
          //                   GetBuilder<SubCatController>(
          //                       builder: (SubCatController) {
          //                     return Positioned(
          //                         top: 0,
          //                         right: 0,
          //                         child: SubCatController
          //                                 .productList.isEmpty
          //                             ? const SizedBox()
          //                             : CircleAvatar(
          //                                 backgroundColor:
          //                                     AppColors.primary,
          //                                 radius: 7,
          //                                 child: Text(
          //                                   SubCatController
          //                                       .productList.length
          //                                       .toString(),
          //                                   style: AppTextStyles
          //                                       .kSmall10SemiboldTextStyle
          //                                       .copyWith(
          //                                           color:
          //                                               AppColors.white),
          //                                 )));
          //                   }),
          //                 ],
          //               )),
          //           // Icon(Icons.notifications,color: AppColors.primary,size: 30,)
          //         ],
          //       ),
          //     )),
        ],
      ),
    );
  }

  Widget title(String title, VoidCallback onTap) {
    return Column(
      children: [
        const Divider(
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.kBody15SemiboldTextStyle,
              ),
              // TextButton(
              //     onPressed: onTap,
              //     child: Text(
              //       'View All',
              //       style: AppTextStyles.kCaption12RegularTextStyle
              //           .copyWith(color: AppColors.primary),
              //     )),
            ],
          ),
        ),
      ],
    );
  }
}
