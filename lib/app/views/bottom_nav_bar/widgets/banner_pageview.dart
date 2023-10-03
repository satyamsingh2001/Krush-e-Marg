import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../const/api_string.dart';

class BannerPageView extends StatefulWidget {
  final String place;
  const BannerPageView({Key? key, required this.place}) : super(key: key);

  @override
  State<BannerPageView> createState() => _BannerPageViewState();
}

class _BannerPageViewState extends State<BannerPageView> {
  List<String> hyperlinkType = [];
  List<String> hyperlink = [];
  List<String> bannerType = [];
  List<String> bannerImage = [];
  List<String> position = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchBanner();
    // controller.fetchBanner();
  }

  // final BannerController controller = Get.find();
  List banner = [];
  Future<void> fetchBanner() async {
    final prefs = await SharedPreferences.getInstance();
    final brearToken = prefs.getString("barrierToken");
    // final id = prefs.getString("id");

    final response = await http.get(Uri.parse(bannerUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $brearToken',
    });

    var suraj = jsonDecode(response.body);
    if (response.statusCode == 200) {
      banner = suraj['data'];
      // print(banner);
      // print(brearToken);
      // print("sssssssssssssssssssssssssssssssssssssss");
      setState(() {});
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    // Format the current day name using the intl package
    String dayName =
        DateFormat('EEEE', Localizations.localeOf(context).toString())
            .format(currentDate);
    // print(dayName.camelCase);


    for (int i = 0; i < banner.length; i++) {
      var weekday = jsonDecode(banner[i]['weekday']);
      if (weekday.contains(dayName.camelCase)&& banner[i]['display'].toString()==widget.place) {
        hyperlinkType.add(banner[i]['hyperlinkType'].toString());
        hyperlink.add(banner[i]['hyperlink'].toString());
        bannerType.add(banner[i]['bannerType'].toString());
        bannerImage.add(banner[i]['image_url'].toString());
        position.add(banner[i]['display'].toString());
        setState(() {});
      }
      // print(position);
    }

    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.2,
      width: size.width,
      child: CarouselSlider.builder(
        options: CarouselOptions(
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            viewportFraction: 0.8,
            autoPlay: true),
        itemCount: bannerImage.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return GestureDetector(
            onTap: () {
              if (hyperlinkType[index] == 'url') {
                launch(hyperlink[index]);
                // launchUrl(hyperlink[index] as Uri);
              } else if (hyperlinkType[index] == 'store') {
                // Get.to(StoreDetails(
                //   storeID: hyperlink[index],
                // ));
              } else if (hyperlinkType[index] == 'category') {
                // Get.to(StoreList(ModuleId: hyperlink[index]));
              } else {}
            },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        banner.isNotEmpty ? bannerImage[index] : '',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                bannerType.isNotEmpty && bannerType[index] == 'sponser'
                    ? Positioned(
                        top: 8,
                        child: Container(
                          alignment: Alignment.center,
                          height: 15,
                          width: 20,
                          decoration: const BoxDecoration(
                              color: AppColors.primary400,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              )),
                          child: const Text(
                            'Ad',
                            style: AppTextStyles.kSmall10SemiboldTextStyle,
                          ),
                        ))
                    : const SizedBox()
              ],
            ),
          );
        },
      ),
    );
  }
}
