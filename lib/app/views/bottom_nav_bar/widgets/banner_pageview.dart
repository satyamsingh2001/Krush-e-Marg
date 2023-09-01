import 'dart:convert';
import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../const/api_string.dart';
import '../../../controller/api_controller.dart';
import '../../shops/views/store_details.dart';
import '../../shops/views/store_list.dart';

class BannerPageView extends StatefulWidget {
  const BannerPageView({Key? key}) : super(key: key);

  @override
  State<BannerPageView> createState() => _BannerPageViewState();
}

class _BannerPageViewState extends State<BannerPageView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchBanner();
    // controller.fetchBanner();

  }
  // BannerController controller = Get.find();

  List banner = [];
  Future<void> fetchBanner() async {
    List<String> storedStrings = await loadStrings();
    // String lat = storedStrings[0].toString();
    // String long = storedStrings[1].toString();
    String lat = '26.8467';
    String long = '80.9462';

    final response = await http.get(Uri.parse('$bannerUrl+$lat,$long'));
    banner = jsonDecode(response.body);
    setState(() {

    });
  }

  // Future<List<String>> loadStrings() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? strings = prefs.getStringList('strings');
  //   return strings ?? [];
  // }

  // List _fetchBanner = [];
  // Future<void> fetchBanner() async {
  //   List<String> storedStrings = await loadStrings();
  //   String lat = storedStrings[0].toString();
  //   String long = storedStrings[1].toString();
  //
  //   final response = await http.get(Uri.parse('$bannerUrl+$lat,$long'));
  //   setState(() {
  //     _fetchBanner = jsonDecode(response.body);
  //   });
  // }


  @override
  Widget build(BuildContext context) {

    setState(() {

    });
    DateTime currentDate = DateTime.now();
    // Format the current day name using the intl package
    String dayName = DateFormat('EEEE', Localizations.localeOf(context).toString()).format(currentDate);
    // print(dayName.camelCase);

    List<String> hyperlinkType = [];
    List<String> hyperlink = [];
    List<String> bannerType = [];
    List<String> bannerImage = [];

    for(int i = 0;i<banner.length;i++){
      var weekday = jsonDecode(banner[i]['weekday']);
      if (weekday.contains(dayName.camelCase)) {
        hyperlinkType.add(banner[i]['hyperlinkType'].toString());
        hyperlink.add(banner[i]['hyperlink'].toString());
        bannerType.add(banner[i]['bannerType'].toString());
        bannerImage.add(banner[i]['image_url'].toString());
        setState(() {

        });
      }
    }

    Size size = MediaQuery.of(context).size;

    return GetBuilder<BannerController>(

      builder: (controller) {
        return SizedBox(
          height: size.height * 0.2,
          width: size.width,
          child: CarouselSlider.builder(
            options: CarouselOptions(
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              viewportFraction: 0.8,
              autoPlay: true
            ),
            itemCount: bannerImage.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {

              return GestureDetector(
                onTap: (){
                  if(hyperlinkType[index]=='url'){
                  launch(hyperlink[index]);
                  // launchUrl(hyperlink[index] as Uri);
                  }else if(hyperlinkType[index]=='store'){
                    Get.to(StoreDetails(storeID: hyperlink[index],));
                  }else if(hyperlinkType[index]=='category'){
                    Get.to(StoreList(ModuleId: hyperlink[index]));
                  }else{}
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(
                            banner.isNotEmpty?bannerImage[index]:'',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                   bannerType.isNotEmpty && bannerType[index]=='sponser'? Positioned(
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
                        )

                      ),
                          child: const Text('Ad',style: AppTextStyles.kSmall10SemiboldTextStyle,),
                    )):const SizedBox()
                  ],
                ),
              );
            },
          ),
        );
      }
    );
  }
}
