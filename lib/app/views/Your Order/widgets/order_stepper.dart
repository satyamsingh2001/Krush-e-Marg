import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
import 'package:krush_e_marg/app/constwidgets/container_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
class OrderStepper extends StatefulWidget {
  const OrderStepper({Key? key}) : super(key: key);

  @override
  State<OrderStepper> createState() => _OrderStepperState();
}

class _OrderStepperState extends State<OrderStepper> {

  List <String> step = ['1','2','3','4'];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ContainerWidget(child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Container(width: size.width*0.15,height: size.height*0.42,
          // color: Colors.black38,
          alignment: Alignment.center,
          child: ListView.builder(
              itemCount: step.length,
              itemBuilder: (BuildContext contex,index){
            return Column(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColors.primary600,
                  child: Text(step[index],style: AppTextStyles.kBody20SemiboldTextStyle.copyWith(color: AppColors.error40),),
                ),
                index!=3?const DottedLine(
                  direction: Axis.vertical,
                  // lineLength: double.infinity,
                  lineLength: 70,
                  lineThickness: 2.0,
                  dashLength: 3.0,
                  dashColor: Colors.red,
                  // dashGradient: [Colors.red, Colors.blue],
                  dashRadius: 0.0,
                  dashGapLength: 2.0,
                  dashGapColor: Colors.transparent,
                  // dashGapGradient: [Colors.white, Colors.black],
                  dashGapRadius: 0.0,
                ):const Text(""),
              ],
            );
          }),

          ),
         Column(
           children: [
             steps('assets/orderstepper/orderplaced.png', 'Order Placed', 'Your order placed\nSuccessfully'),
             steps('assets/orderstepper/ontheway.png', 'On the Way', 'Our agent will\ndeliver the products'),
             steps('assets/orderstepper/arrived.png', 'Order Arrived', 'Our agent has\narrived at your door'),
             steps('assets/orderstepper/delivered.png', 'Order Delivered', 'Our agent has\ndelivered the products'),
           ],
         ),
        ],),
      )),
    );
  }
  Widget steps(
      String img,
      String title,
      String subtitle,
      ){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(img,height: 100,width: 100,),
        const SizedBox(width: 10,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,style: AppTextStyles.kBody17SemiboldTextStyle,),
            Text(subtitle,style: AppTextStyles.kCaption12RegularTextStyle.copyWith(color: AppColors.white80),),
          ],
        )
      ],
    );
  }

}
