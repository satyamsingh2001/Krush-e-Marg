import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krush_e_marg/app/controller/api_controller.dart';

import '../../../../colors/colors_const.dart';
import '../../../../test2.dart';
import '../../../../textstyles/textstyle_const.dart';
import '../../views/recom_prod/rec_prod.dart';
import '../../views/top_sellling/top_sell_page.dart';
import '../../widgets/banner_pageview.dart';
import 'package:krush_e_marg/app/controller/product_db_controller.dart';
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
    print('Search Text: $searchText'); // Add this line
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 80,
        title: SizedBox(
          height: 50,
          child: Row(
            children: [
              SizedBox(
                width: size.width * 0.7,
                child: TextFormField(
                  controller: searchController,
                  onChanged: onSearchTextChanged,
                  decoration: InputDecoration(
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    fillColor: const Color.fromRGBO(203, 212, 225, 1),
                    hintText: 'Search for any categories',
                    hintStyle: const TextStyle(fontSize: 14),
                    suffixIcon:
                    const Icon(Icons.search, color: AppColors.primary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColors.white40,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: const Icon(
              Icons.notifications,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          InkWell(
            onTap: () {},
            child: const Icon(
              Icons.shopping_cart,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(
            width: 12,
          )
        ],
        elevation: 0,
        backgroundColor: AppColors.white10,
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
                          catId: cat['id'].toString(),

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
                              child: Image.network(
                                cat['image_url'],
                                height: 60,
                                width: 60,
                                fit: BoxFit.fill,
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
              TextButton(
                onPressed: onTap,
                child: Text(
                  'View All',
                  style: AppTextStyles.kCaption12RegularTextStyle
                      .copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
