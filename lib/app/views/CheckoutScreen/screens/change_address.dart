import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'addnewaddress.dart';
class ChangeAddress extends StatefulWidget {
  const ChangeAddress({Key? key}) : super(key: key);

  @override
  State<ChangeAddress> createState() => _ChangeAddressState();
}

class _ChangeAddressState extends State<ChangeAddress> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          )
      ),
      child:Column(
        children: [
          const SizedBox(height: 15,),
          const Text('Select an Address',style: AppTextStyles.kBody17SemiboldTextStyle,),
          const SizedBox(height: 15,),
          const Divider(thickness: 1,height: 1,),
          InkWell(
            onTap: (){
              Get.to(const AddNewAddresMap());
            },
            child: SizedBox(
              height: 50,
              width: size.width,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.add_circle_outline_rounded,color: AppColors.primary,size: 20,),
                  ),
                  Text('Add Address',style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.primary),)
                ],
              ),
            ),
          ),
          const Divider(thickness: 1,height: 1,),
          const SizedBox(height: 16.0,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('SAVED ADDRESSES',style: AppTextStyles.kBody15RegularTextStyle.copyWith(color: AppColors.white70),)),
          ),
          const Divider(thickness: 1,height: 1,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('You are currently near',style: AppTextStyles.kBody15RegularTextStyle.copyWith(color: AppColors.success40),)),
          ),
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification){
                  notification.disallowIndicator();
                  return true;
                },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                  itemCount: 22,
                  itemBuilder: (BuildContext context,index){
                return Column(
                  children: [
                    ListTile(
                      leading: const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Icon(Icons.location_on,color: AppColors.primary600,),
                      ),
                      horizontalTitleGap: 0,
                      title: Text('COMPANY',style:AppTextStyles.kCaption12SemiboldTextStyle.copyWith(color: AppColors.primary),),
                      subtitle: const Text(
                          'arjh tech lab sector-62 noida ',),

                      trailing: PopupMenuButton(
                        elevation: 1.5,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),),
                        itemBuilder: (contex){
                          return [
                            PopupMenuItem(
                              padding: const EdgeInsets.all(5),
                              onTap: (){},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:const [
                                  Text('Delete Address'),
                                  Icon(Icons.delete_forever_rounded),
                                ],
                              ),
                            ),
                          ];
                        },
                      ),
                    )
                  ],
                );
              }),
            )
          )
        ],
      )
    );
  }
}
