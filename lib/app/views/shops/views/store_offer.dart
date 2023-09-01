import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';

import '../../../colors/colors_const.dart';
import '../../../const/api_string.dart';
import '../../../textstyles/textstyle_const.dart';
import '../../../constwidgets/container_widget.dart';
class StoerOffer extends StatefulWidget {
  final String storeId;
  final String category;
  const StoerOffer({Key? key, required this.category,required this.storeId}) : super(key: key);

  @override
  State<StoerOffer> createState() => _StoerOfferState();
}

class _StoerOfferState extends State<StoerOffer> {

  @override
  void initState() {
    super.initState();
    storeID=widget.storeId;
    storeWithId();
    fetchCoupons();
  }

  String storeID="";

  var map;
  Future storeWithId() async {
    final response = await http.get(
      Uri.parse("$store_with_id+$storeID"),
    );
    var data = jsonDecode(response.body);
    if (data['status']==1) {
      setState(() {
      });
      map = data['data'];
    }
  }

  List storeCoupon = [];
  Future<void> fetchCoupons() async {
    final response = await http.get(Uri.parse(
        '$baseurl/api/fetchCoupons/$storeID'));
    setState(() {
      storeCoupon = jsonDecode(response.body);
    });
    if (response.statusCode == 200) {
      // print(storeCoupon);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String timeType =map==null?'': map['timeType']=='minutes'?'min':"hr";
    return  ContainerWidget(
        // height: size.height*0.21,
        child: map==null?const Center(child: CircularProgressIndicator(color: AppColors.primary,))
            :Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width*0.4,
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          map['name'].toString(),
                          style: AppTextStyles
                              .kBody17SemiboldTextStyle,
                        ),
                        Text(
                          textAlign: TextAlign.start,
                          widget.category,
                          style: AppTextStyles
                              .kCaption12RegularTextStyle
                              .copyWith(color: AppColors.white90),
                        ),
                        Text(
                          map['address'].toString(),
                          style: AppTextStyles
                              .kCaption12RegularTextStyle
                              .copyWith(color: AppColors.white70),
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.success40,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text(
                                    "4.1",
                                    style: TextStyle(color: AppColors.white),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: AppColors.white,
                                    size: 15,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: size.width*0.05,),
                            Row(
                              children: [
                                Text(
                                    // textAlign: TextAlign.center,
                                    map['minTime']+'-'+map['maxTime']+timeType),
                                const Icon(Icons.access_time_rounded,size: 15,color: AppColors.primary,),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      map['logo_url'].toString(),
                      height: 80,
                      width: 80,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
           storeCoupon.isEmpty?const SizedBox(): Padding(
             padding: const EdgeInsets.only(bottom: 8),
             child: SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                    itemCount: storeCoupon.length,
                    itemBuilder: (BuildContext context,index){
                      String discount = storeCoupon[index]['discount'].toString();
                      String discountType = storeCoupon[index]['discountType'];
                      String discountCode = storeCoupon[index]['code'].toString();
                      return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: size.width*0.6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.white30,width: 1.5),
                          color: AppColors.white10
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 0,),
                          Image.asset('assets/icons/storeoffer.png',height: 35,width: 35,),
                          Container(
                            width: size.width*0.43,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    discountType=='amount'?
                                    '₹$discount OFF':'$discount% OFF',style: AppTextStyles.kBody15SemiboldTextStyle,),
                                  RichText(
                                    text: TextSpan(
                                      text: 'use code ',
                                      style: AppTextStyles.kCaption12RegularTextStyle.copyWith(color: AppColors.white70),
                                      children: <TextSpan>[
                                        TextSpan(text: discountCode, style: AppTextStyles.kCaption12SemiboldTextStyle.copyWith(color: AppColors.white90)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],),
                    ),
                  );
                }),
              ),
           ),
          ],
        ));
  }
}
