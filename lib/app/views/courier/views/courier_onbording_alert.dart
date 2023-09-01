import 'package:krush_e_marg/app/views/courier/screens/screen1.dart';
import 'package:krush_e_marg/app/views/courier/screens/screen2.dart';
import 'package:krush_e_marg/app/views/courier/screens/screen3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../colors/colors_const.dart';
class CourierOnbordingAlert extends StatefulWidget {
  const CourierOnbordingAlert({Key? key}) : super(key: key);

  @override
  State<CourierOnbordingAlert> createState() => _CourierOnbordingAlertState();
}

class _CourierOnbordingAlertState extends State<CourierOnbordingAlert> {
  final PageController controller = PageController();
  bool _showingAlert = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      child: Container(
        alignment: Alignment.center,
        // color: Colors.transparent,
        child: SizedBox(
          width: size.width * 0.95,
          height: size.height * 0.8,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Container(
                  //   height: size.height * 0.390,
                  //   decoration: BoxDecoration(
                  //       color: Colors.red,
                  //       boxShadow: [
                  //         BoxShadow(
                  //             blurRadius: 5,
                  //             spreadRadius: 1,
                  //             offset: const Offset(0, 2))
                  //       ],
                  //       borderRadius: const BorderRadius.only(
                  //           topLeft: Radius.circular(30),
                  //           topRight: Radius.circular(30))),
                  // ),
                  SizedBox(
                    height: size.height,
                    child: PageView(
                      controller: controller,
                      children: [
                        Screen1(controller: controller),
                        Screen2(controller: controller),
                        Screen3(controller: controller),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: size.height * 0.11,
                    child: SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        effect: const ExpandingDotsEffect(
                          dotHeight: 10,
                          dotWidth: 10,
                          activeDotColor: AppColors.white40,
                          dotColor: AppColors.white30,
                        )),
                  ),
                  Positioned(
                    top: -10,
                    right: -10,
                    child:  IconButton(
                    icon: Icon(Icons.cancel_outlined,size: 30,),
                    onPressed: () {
                      setState(() {
                        _showingAlert = false;
                      });
                      Navigator.of(context).pop();
                    },
                  ),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
