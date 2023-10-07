import 'package:krush_e_marg/app/constwidgets/container_widget.dart';
import 'package:krush_e_marg/app/controller/api_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../colors/colors_const.dart';
import '../../../../constwidgets/counter_widgets.dart';
import '../../../../database/database_helper2.dart';
import '../../../../textstyles/textstyle_const.dart';


class VarientBottmSheet extends StatefulWidget {
 final List varientsDetails;
 final String productImg;
 final String productName;
 final String storeName;
 final String storeId;
 final String pId;
 final String pAttributes;

  const VarientBottmSheet({super.key, required this.varientsDetails, required this.productImg, required this.productName, required this.storeName, required this.pId, required this.pAttributes, required this.storeId});

  @override
  State<VarientBottmSheet> createState() => _VarientBottmSheetState();
}

class _VarientBottmSheetState extends State<VarientBottmSheet> {

  @override
  void initState() {
    super.initState();
    output=widget.varientsDetails;
    // SubCatController.fetchSubCat();
  }

  // List<Product> productList = [];
  // void fetchProducts() async {
  //   final products = await ProductDatabase.instance.fetchProducts();
  //   setState(() {
  //     productList = products;
  //   });
  // }

  List output=[];
   int productCount=0;
   List varientQuant = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          )),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.productName,
                  style: AppTextStyles.kBody17SemiboldTextStyle,
                ),
                const SizedBox(
                  height: 5,
                ),
                GetBuilder<SubCatController>(
                  builder: (subCatController) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: output.length,
                        itemBuilder: (BuildContext context,index){
                        final variant = output[index];
                        var vMrp = double.parse(variant['price'].toString());
                        var vType = variant["type"].toString();
                        var vUnit = variant["unit"].toString();
                        var vDiscountType = variant["discountType"].toString();
                        var vDiscount = double.parse(variant["discount"].toString());
                        var vPrice = vDiscountType=='amount'?vMrp-vDiscount:vMrp-((vMrp*vDiscount)/100);
                        var vQuantity = variant['type'].toString()+variant['unit'].toString();
                        var vOffDiscount = vDiscountType=='amount'?'₹${vDiscount.toInt()}':"${vDiscount.toInt()}%";

                        bool show = false;
                        if (subCatController.subCatList.isNotEmpty) {
                          for (var i = 0; i < subCatController.subCatList.length; i++) {
                            var databasePID = subCatController.subCatList[i].productId;
                            var databasePsize = subCatController.subCatList[i].size;
                              varientQuant =List.generate(output.length, (index) => subCatController.subCatList[i].quantity);
                            if (databasePID ==widget.pId && databasePsize == int.parse(vType)) {
                              show = true;
                              break;
                            }
                          }
                        }

                      return  Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.5),
                        child: ContainerWidget(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      widget.productImg,
                                      height: 45,
                                      width: 45,
                                      fit: BoxFit.fill,
                                    )),
                                Column(
                                  children: [
                                    Text(
                                      vQuantity,
                                      style: AppTextStyles.kCaption12SemiboldTextStyle
                                          .copyWith(color: AppColors.white60),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '₹${vPrice.toInt()}',
                                      style: AppTextStyles.kCaption12SemiboldTextStyle,
                                    ),
                                    Text(
                                      '₹${vMrp.toInt()}',
                                      style: AppTextStyles
                                          .kSmall10RegularTextStyle
                                          .copyWith(
                                          color: AppColors.white60,
                                          decoration:
                                          TextDecoration.lineThrough),
                                    )
                                  ],
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/off.png',
                                      height: 35,
                                      width: 35,
                                    ),
                                    Positioned(
                                        child: Column(
                                          children: [
                                            Text(vOffDiscount,style: AppTextStyles.kSmall8SemiboldTextStyle.copyWith(color: AppColors.white),),
                                            Text('off',style: AppTextStyles.kSmall8SemiboldTextStyle.copyWith(color: AppColors.white),),
                                          ],
                                        )),
                                  ],
                                ),
                                !show
                                    ? SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: InkWell(
                                      onTap: () {
                                        addProductToDatabase(
                                          widget.productName,
                                            vPrice,
                                            vMrp,
                                            widget.storeName,
                                            widget.productImg,
                                            int.parse(vType),
                                            widget.pId,
                                            widget.storeId,
                                            vUnit,
                                            1,
                                            widget.pAttributes);
                                        // SubCatController.fetchSubCat();
                                      },
                                      child: const Card(
                                        elevation: 1,
                                        child: Icon(
                                          Icons.add,
                                          size: 18,
                                          color: AppColors.primary,
                                        ),
                                      )),
                                )
                                    : CounterWidget(
                                  height: size.height*0.032,
                                  width: size.width*0.18,
                                  plusOntap: () {
                                    for(var i = 0; i<subCatController.subCatList.length;i++){
                                      var productId = subCatController.subCatList[i].productId;
                                      var productSize = subCatController.subCatList[i].size;
                                      if(productId==widget.pId&&productSize==int.parse(vType))
                                      {
                                        updateProduct(
                                            widget.pId,
                                            int.parse(vType),
                                            subCatController.subCatList[i].quantity!.toInt()+1);
                                        // SubCatController.fetchSubCat();
                                      }
                                    }
                                  },
                                  minusOntap: () {
                                    for(var j = 0; j<subCatController.subCatList.length;j++){
                                      var productId = subCatController.subCatList[j].productId;
                                      var productSize = subCatController.subCatList[j].size;
                                      if(productId==widget.pId&&productSize==int.parse(vType))
                                      {
                                        if (subCatController.subCatList[j].quantity!.toInt() > 1) {
                                          updateProduct(
                                              widget.pId,
                                              int.parse(vType),
                                              subCatController.subCatList[j].quantity!.toInt()-1);
                                        }else{
                                          removeProduct(subCatController.subCatList[j].id!.toInt());
                                        }
                                      }
                                      // SubCatController.fetchSubCat();
                                    }
                                  },
                                  // counterValue:productList[index2].quantity,
                                  counterValue:varientQuant[index],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
                  }
                ),
                const SizedBox(height: 5,),
                // Align(
                //   alignment: Alignment.center,
                //   child: Container(
                //     height: 45,
                //     width: size.width*0.9,
                //     decoration: BoxDecoration(
                //       color: AppColors.primary,
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text('8 Item',style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white),),
                //           Container(
                //             height: 15,
                //             width: 2,
                //             color: Colors.white,
                //           ),
                //           Text('₹400',style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white),),
                //
                //           SizedBox(
                //             width: size.width*0.45,
                //           ),
                //           InkWell(
                //             onTap: (){
                //               Get.back();
                //             },
                //               child: Text('Done',style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white),)),
                //         ],),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
