import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
import 'package:krush_e_marg/app/views/bottom_nav_bar/product/product_page.dart';
import 'package:krush_e_marg/app/views/bottom_nav_bar/reels/reels_page.dart';
import 'package:krush_e_marg/app/views/bottom_nav_bar/views/home_page.dart';
import '../../colors/colors_const.dart';
import '../../controller/api_controller.dart';
import '../../controller/product_db_controller.dart';
import 'community/community.dart';
import 'community/controller/api.dart';
import 'community/controller/toggle_controller.dart';
import 'community/controller/update_ls_controller.dart';
import 'shops/views/shope_page.dart';

class DashBoardScreenMain extends StatefulWidget {
  final int? currentIndex;
  const DashBoardScreenMain({super.key, this.currentIndex});

  @override
  State<DashBoardScreenMain> createState() => _DashBoardScreenMainState();
}

class _DashBoardScreenMainState extends State<DashBoardScreenMain> {
  final CommunityController communityController = Get.put(CommunityController());
  final CategoriesController categoriesController = Get.put(CategoriesController());
  final ProductController productController = Get.put(ProductController());

  final UpdateLSController updateLSController = Get.put(UpdateLSController());
  final ToggleController toggleController = Get.put(ToggleController());
  late int currentIndex;


  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex??0;
  }
 List screens = [
  const HomePage(),
  const ShopPage(),
  const BottomProductPage(),
  const Community(),
  const Reels(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: currentIndex<3?FloatingActionButton(
        onPressed: () {
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const DashBoardScreenMain(currentIndex: 3,)));
        },
        backgroundColor: AppColors.primary,
        child: Text("Sell",style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white),),)
          :null,
      floatingActionButtonLocation:currentIndex==0? FloatingActionButtonLocation.endFloat:null, // Change this to the desired location.

      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primary,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedItemColor: AppColors.white60,
        unselectedFontSize: 10,
        unselectedIconTheme: const IconThemeData(
          color: AppColors.white60,
        ),
        selectedIconTheme: const IconThemeData(
          color: AppColors.primary,
        ),
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
        
          BottomNavigationBarItem(
            icon: Icon(Icons.shopify_rounded),
            label: 'Shops',
          ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.shopping_bag_outlined),
            icon: Icon(Icons.redeem),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.groups),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection_outlined),
            label: 'Reels',
          ),
        ],
      ),
    );
  }
}