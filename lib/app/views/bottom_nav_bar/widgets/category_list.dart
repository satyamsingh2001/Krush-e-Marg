import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';

import '../../../colors/colors_const.dart';
import '../../../controller/api_controller.dart';
import '../shops/views/product_list.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  void initState() {
    super.initState();
    // categoriesController.fetchCat();
    // categoriesController.fetchCategories();
  }

  CategoriesController categoriesController = Get.find();
  final SubCatController subCatController = Get.find();


  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesController>(
      builder: (categoriesController) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: categoriesController.categoriesList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
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
                      CachedNetworkImage(
                      imageUrl:  cat['image_url'], // Replace with your image URL
                      // placeholder: (context, url) => CircularProgressIndicator(), // Placeholder while loading
                      errorWidget: (context, url, error) => const Icon(Icons.error), // Error widget
                      width: 60, // Specify the desired width
                      height: 60, // Specify the desired height
                      fit: BoxFit.cover, // Specify the desired fit
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
        );
      }
    );
  }
}
