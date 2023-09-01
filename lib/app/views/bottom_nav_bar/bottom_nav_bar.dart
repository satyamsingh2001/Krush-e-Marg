import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krush_e_marg/app/views/bottom_nav_bar/product/product_page.dart';
import 'package:krush_e_marg/app/views/bottom_nav_bar/views/home_page.dart';
import '../../colors/colors_const.dart';
import '../shops/views/shope_page.dart';

class DashBoardScreenMain extends StatefulWidget {
  final int? currentIndex;
  const DashBoardScreenMain({super.key, this.currentIndex});

  @override
  State<DashBoardScreenMain> createState() => _DashBoardScreenMainState();
}

class _DashBoardScreenMainState extends State<DashBoardScreenMain> {

  late int _currentIndex;

  List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomePage(),
      // const ViewAllOffers(),
      const ShopPage(),
      const BottomProductPage()
      // CourierScreen(),
      // const YourOrder(),
      // const ProfileScreen(),
    ];
    _currentIndex = widget.currentIndex??0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
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
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // if (index == 3) {
          //   showDialog(
          //     context: context,
          //     builder: (BuildContext context) {
          //       return const CourierOnbordingAlert();
          //     },
          //   );
          // }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.discount),
          //   label: 'Offers',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopify_rounded),
            label: 'Shops',
          ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.shopping_bag_outlined),
            icon: Icon(Icons.redeem),
            label: 'Product',
          ),
          // BottomNavigationBarItem(
          //   icon:Icon(Icons.wallet_giftcard_outlined),
          //   label: 'Orders',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(CupertinoIcons.person_crop_circle),
          //   label: 'Profile',
          // ),
        ],
      ),
    );
  }
}