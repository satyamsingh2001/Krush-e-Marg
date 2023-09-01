import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
import 'package:krush_e_marg/app/constwidgets/container_widget.dart';
import 'package:krush_e_marg/app/views/shops/views/store_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../colors/colors_const.dart';
import '../../../const/api_string.dart';

class StoreList extends StatefulWidget {
  final String ModuleId;
  const StoreList({Key? key, required this.ModuleId}) : super(key: key);

  @override
  State<StoreList> createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {
  final TextEditingController _searchController = TextEditingController();

  bool _loading = true;
  @override
  void initState() {
    super.initState();
    ModuleID = widget.ModuleId;
    storeWithModule();
  }

  String ModuleID = "";
  List storeDetails = [];
  Future<void> storeWithModule() async {
    final response = await http.get(Uri.parse('$store_with_module+$ModuleID'));
    List stores = jsonDecode(response.body)['data'];

    if (response.statusCode == 200) {
      setState(() {
        storeDetails = stores;
        filterStore = List.from(stores);
        _loading = false;
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }

  List filterStore = [];
  void filterStoreByName(String query) {
    setState(() {
      if (query.isEmpty) {
        // If the search query is empty, show all modules
        filterStore = List.from(storeDetails);
      } else {
        // Filter modules based on the search query
        filterStore = storeDetails
            .where((store) => store['name']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _loading
        ? Container(
            color: AppColors.white,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const SizedBox(
                    height: 70,
                    width: 70,
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2.5,
                    )),
                Image.asset(
                  'assets/images/applogo.png',
                  height: 60,
                  width: 60,
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              centerTitle: true,
              elevation: 0,
              backgroundColor: AppColors.white,
              automaticallyImplyLeading: false,
              title: SizedBox(
                height: 50,
                child: TextFormField(
                  onChanged: filterStoreByName,
                  controller: _searchController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    fillColor: const Color.fromRGBO(203, 212, 225, 1),
                    hintText: 'Search for any store',
                    prefixIcon: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.white100,
                        )),
                    suffixIcon: const Icon(Icons.search,
                        color: Color.fromRGBO(226, 62, 87, 1)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: AppColors.primary700,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: AppColors.primary700,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // const CategoryWidgets(),
                  // const SizedBox(height: 10),
                  SizedBox(
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: filterStore.length,
                        itemBuilder: (BuildContext contex, int index) {
                          final store = filterStore[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(StoreDetails(
                                  storeID: store['id'].toString(),
                                ));
                              },
                              child: ContainerWidget(
                                  height: 90,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: Image.network(
                                            store['cover_url'].toString(),
                                            height: 60,
                                            width: 60,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              store['name'].toString(),
                                              style: AppTextStyles
                                                  .kBody15SemiboldTextStyle,
                                            ),
                                            Text(
                                              store['address'].toString(),
                                              style: AppTextStyles
                                                  .kCaption12RegularTextStyle
                                                  .copyWith(
                                                      color: AppColors.white70),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            SizedBox(
                                              width: size.width * 0.55,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      const Text(
                                                        '3.5',
                                                        style: AppTextStyles
                                                            .kCaption12SemiboldTextStyle,
                                                      ),
                                                      Text(
                                                        'Reviews',
                                                        style: AppTextStyles
                                                            .kSmall10RegularTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .white70),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        store['all_products']
                                                            .toString(),
                                                        style: AppTextStyles
                                                            .kCaption12SemiboldTextStyle,
                                                      ),
                                                      Text(
                                                        'Products',
                                                        style: AppTextStyles
                                                            .kSmall10RegularTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .white70),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      const Text(
                                                        '3.5 km',
                                                        style: AppTextStyles
                                                            .kCaption12SemiboldTextStyle,
                                                      ),
                                                      Text(
                                                        'Distance',
                                                        style: AppTextStyles
                                                            .kSmall10RegularTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .white70),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
  }
}
