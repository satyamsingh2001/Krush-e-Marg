import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krush_e_marg/app/controller/api_controller.dart';
import 'package:krush_e_marg/app/controller/product_db_controller.dart';
import '../../../../colors/colors_const.dart';
import '../../../../textstyles/textstyle_const.dart';
import '../../../CheckoutScreen/views/checkout_screen.dart';
import '../../views/recom_prod/rec_prod.dart';
import '../../views/top_sellling/top_sell_page.dart';
import '../../widgets/banner_pageview.dart';
import 'product_list.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  TextEditingController searchController = TextEditingController();
  final CategoriesController categoriesController = Get.find();
  final ProductController productController = Get.find();

  final SubCatController subCatController = Get.find();

  String searchText = "";

  @override
  void initState() {
    super.initState();
  }

  void onSearchTextChanged(String text) {
    setState(() {
      searchText = text;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Krush e Marge'),
        actions: [
          // InkWell(
          //     // onTap: () {
          //     //   Navigator.push(
          //     //       context,
          //     //       MaterialPageRoute(
          //     //           builder: (context) => const DashBoardScreenMain(
          //     //             currentIndex: 1,
          //     //           )));
          //     // },
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
      body: GetBuilder<CategoriesController>(
        builder: (categoriesController) {
          return NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator();
              return true;
            },
            child: ListView(
              children: [
                const SizedBox(height: 20,),
                 SizedBox(
                  height: 100,
                  child: ListView.builder(
                      itemCount: categoriesController.categoriesList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                    final cat = categoriesController.categoriesList[index];
                    return index <=categoriesController.categoriesList.length
                        ? GestureDetector(
                      onTap: () {
                        subCatController.fetchSubCat(cat['id'].toString(),);

                        Get.to( ProductList(
                          catId: '${cat['id']}',

                        ));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: AppColors.white30,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                  color: AppColors.white40,
                                  spreadRadius: 0.5,
                                  blurRadius: 1,
                                  offset: Offset(0, 1))
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child:  CachedNetworkImage(
                                imageUrl: cat['image_url'],
                                // placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                width: 60, // Specify the desired width
                                height: 60,
                                fit: BoxFit.cover,
                              ),

                            ),
                            Text(
                              cat['name'] ?? '',
                              style: AppTextStyles.kSmall10RegularTextStyle,
                            ),
                          ],
                        ),
                      ),
                    )
                        : null;
                  }
                  ),
                  // child: CategoryList(),
                ),
                title('Recommended Products', () {}),
                const RecProductPage(),
                title('Top Selling Products', () {}),
                const TopSellingPage(),
                const Divider(
                  thickness: 1,
                ),
                 const BannerPageView(
                  place: 'shop_bottom',
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          );
        }
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.kBody15SemiboldTextStyle,
              ),
              // TextButton(
              //   onPressed: onTap,
              //   child: Text(
              //     'View All',
              //     style: AppTextStyles.kCaption12RegularTextStyle
              //         .copyWith(color: AppColors.primary),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
