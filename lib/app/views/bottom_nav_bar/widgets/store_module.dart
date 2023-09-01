import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../colors/colors_const.dart';
import '../../../const/api_string.dart';
import '../../../controller/api_controller.dart';
import '../../../textstyles/textstyle_const.dart';
import '../../shops/views/store_details.dart';
import '../../shops/views/store_list.dart';
import 'explore_modules_widget.dart';
class StoreModule extends StatefulWidget {
  const StoreModule({Key? key}) : super(key: key);

  @override
  State<StoreModule> createState() => _StoreModuleState();
}

class _StoreModuleState extends State<StoreModule> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moduleController.fetchModules();
    // fetchModules();
  }

  // Future<List<String>> loadStrings() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? strings = prefs.getStringList('strings');
  //   return strings ?? [];
  // }

  // List modulesName = [];
  // Future<void> fetchModules() async {
  //   List<String> storedStrings = await loadStrings();
  //   String lat = storedStrings[0].toString();
  //   String long = storedStrings[1].toString();
  //
  //   final response = await http.get(Uri.parse('$moduleUrl+$lat,$long'));
  //   setState(() {
  //     modulesName = jsonDecode(response.body)['data'];
  //   });
  //   if (response.statusCode == 200) {
  //
  //   } else {
  //     throw Exception('Failed to load categories');
  //   }
  // }

  ModuleController moduleController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ModuleController>(
      builder: (moduleController) {
        return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: moduleController.modulesName.length,
            itemBuilder: (BuildContext context,index1){
              final module = moduleController.modulesName[index1];
              return  Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        module['name'].toString(),
                        // 'Explore food',
                        style: AppTextStyles.kBody17SemiboldTextStyle,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(StoreList(ModuleId: module['id'].toString()));
                        },
                        child: Text(
                          'View All',
                          style: AppTextStyles.kCaption12RegularTextStyle
                              .copyWith(color: AppColors.primary700),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height*0.2,
                  child: ListView.builder(
                      itemCount: module['store'].length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context,index2){
                        final store = module['store'][index2];
                        String minTime = store['minTime'].toString();
                        String maxTime = store['maxTime'].toString();
                        String timeType = store['timeType']=='minutes'?'min':'hr';
                        return GestureDetector(
                          onTap: (){
                            Get.to(StoreDetails(
                              storeID: store['id'].toString(),
                            ));
                          },
                          child: ExploreModulesWidgets(
                            image: store['cover_url'].toString(),
                            time: '$minTime-$maxTime$timeType',
                            title: store['name'].toString(),
                            rate: '4.1',
                          ),
                        );
                      }),
                )
              ],);
            });
      }
    );
  }
}
