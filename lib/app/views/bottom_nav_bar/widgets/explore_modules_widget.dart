import 'package:flutter/material.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';

import '../../../colors/colors_const.dart';

class ExploreModulesWidgets extends StatefulWidget {
  final String image;
  final String title;
  final String rate;
  final String time;

  const ExploreModulesWidgets(
      {super.key,
      required this.image,
      required this.title,
      required this.rate,
      required this.time});

  @override
  State<ExploreModulesWidgets> createState() => _ExploreFoodWidgetItemsState();
}

class _ExploreFoodWidgetItemsState extends State<ExploreModulesWidgets> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        width:size.width*0.33,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: const Color.fromARGB(255, 210, 207, 207),
            )),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.image,
                  fit: BoxFit.fill,
                  // width: size.width,
                  height: size.height*0.11,
                ),
              ),
              Align(
                alignment:  Alignment.centerLeft,
                child: Text(
                  widget.title,
                  style: AppTextStyles.kBody15SemiboldTextStyle,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 18,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: AppColors.success40,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.rate,
                          style: AppTextStyles.kCaption12RegularTextStyle.copyWith(color: AppColors.white),
                        ),
                        const Icon(
                          Icons.star,
                          color: AppColors.white,
                          size: 12,
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(widget.time,style: AppTextStyles.kSmall10RegularTextStyle.copyWith(color: AppColors.white70),),
                      // Image.asset('assets/images/StopWatch.png')
                      const Icon(Icons.watch_later_outlined,color: AppColors.primary,size: 15,),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
