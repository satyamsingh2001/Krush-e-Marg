import 'package:krush_e_marg/app/constwidgets/container_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../colors/colors_const.dart';
import '../../../textstyles/textstyle_const.dart';

class LikesShops extends StatefulWidget {
  const LikesShops({Key? key}) : super(key: key);

  @override
  State<LikesShops> createState() => _LikesShopsState();
}

class _LikesShopsState extends State<LikesShops> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8.0),
            child: ContainerWidget(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                        height: 150,
                        width: size.width,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network("https://media.istockphoto.com/id/871227828/photo/unrecognizable-woman-shops-for-produce-in-supermarket.jpg?b=1&s=612x612&w=0&k=20&c=l1Z4BaT-ving-uBAZHAA7kE6B3sEDSVQG1O1DiLgOOQ=",fit: BoxFit.fill,))),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Ashok Bhojnalya",style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white100),),
                            const SizedBox(height: 5,),
                            Text("Fast Food, Street Foood, Sandwich",style: AppTextStyles.kCaption12RegularTextStyle.copyWith(color: AppColors.white60),),
                            Text("Tedhi Puliya Lucknow",style: AppTextStyles.kSmall10RegularTextStyle.copyWith(color: AppColors.white60),),

                          ],
                        ),
                        const Spacer(),
                        IconButton(onPressed: (){
                          showModalBottomSheet(
                              context: (context),
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context){
                            return Container(
                              height: 155,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                )
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text("Share",style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white100),),
                                    subtitle: Text("Share this product",style: AppTextStyles.kCaption12RegularTextStyle.copyWith(color: AppColors.white60),),
                                    trailing: const Icon(CupertinoIcons.arrow_turn_up_right),
                                  ),
                                  ListTile(
                                    title: Text("Delete",style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white100),),
                                    subtitle: Text("Reomove this product from likes",style: AppTextStyles.kCaption12RegularTextStyle.copyWith(color: AppColors.white60),),
                                    trailing: const Icon(CupertinoIcons.delete),
                                  ),
                                ],
                              ),
                            );
                          });
                        }, icon: const Icon(Icons.more_horiz_rounded))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
